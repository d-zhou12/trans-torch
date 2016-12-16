require('nn')
require('cunn')
require('cudnn')

require('transtorch')

torch.setdefaulttensortype('torch.FloatTensor')

local torchNet = torch.load('./resnet-34.t7')
local caffeNet = transTorch.loadCaffe('./resnet-34.prototxt');

-- entry
local conv = torchNet:get(1)
transTorch.toCaffe(conv, caffeNet, 'conv1')
local bn = torchNet:get(2)
transTorch.toCaffe(bn, caffeNet, {'bn1', 'scale1'})

-- block a
for i = 1, 2 do
    conv = torchNet:get(5):get(i):get(1):get(1):get(1)
    transTorch.toCaffe(conv, caffeNet, 'resa_L' .. i .. '_conv1')

    bn = torchNet:get(5):get(i):get(1):get(1):get(2)
    local bnName = 'resa_L' .. i .. '_bn1'
    local scaleName = 'resa_L' .. i .. '_scale1'
    transTorch.toCaffe(bn, caffeNet, {bnName, scaleName})

    conv = torchNet:get(5):get(i):get(1):get(1):get(4)
    transTorch.toCaffe(conv, caffeNet, 'resa_L' .. i .. '_conv2')

    bn = torchNet:get(5):get(i):get(1):get(1):get(5)
    local bnName = 'resa_L' .. i .. '_bn2'
    local scaleName = 'resa_L' .. i .. '_scale2'
    transTorch.toCaffe(bn, caffeNet, {bnName, scaleName})
end

--block b
for i = 1, 4 do
    conv = torchNet:get(6):get(i):get(1):get(1):get(1)
    transTorch.toCaffe(conv, caffeNet, 'resb_L' .. i .. '_conv1')

    bn = torchNet:get(6):get(i):get(1):get(1):get(2)
    local bnName = 'resb_L' .. i .. '_bn1'
    local scaleName = 'resb_L' .. i .. '_scale1'
    transTorch.toCaffe(bn, caffeNet, {bnName, scaleName})

    conv = torchNet:get(6):get(i):get(1):get(1):get(4)
    transTorch.toCaffe(conv, caffeNet, 'resb_L' .. i .. '_conv2')

    bn = torchNet:get(6):get(i):get(1):get(1):get(5)
    local bnName = 'resb_L' .. i .. '_bn2'
    local scaleName = 'resb_L' .. i .. '_scale2'
    transTorch.toCaffe(bn, caffeNet, {bnName, scaleName})
end
conv = torchNet:get(6):get(1):get(1):get(2)
transTorch.toCaffe(conv, caffeNet, 'resb_L1_branch_conv1')

--block c
for i = 1, 6 do
    conv = torchNet:get(7):get(i):get(1):get(1):get(1)
    transTorch.toCaffe(conv, caffeNet, 'resc_L' .. i .. '_conv1')

    bn = torchNet:get(7):get(i):get(1):get(1):get(2)
    local bnName = 'resc_L' .. i .. '_bn1'
    local scaleName = 'resc_L' .. i .. '_scale1'
    transTorch.toCaffe(bn, caffeNet, {bnName, scaleName})

    conv = torchNet:get(7):get(i):get(1):get(1):get(4)
    transTorch.toCaffe(conv, caffeNet, 'resc_L' .. i .. '_conv2')

    bn = torchNet:get(7):get(i):get(1):get(1):get(5)
    local bnName = 'resc_L' .. i .. '_bn2'
    local scaleName = 'resc_L' .. i .. '_scale2'
    transTorch.toCaffe(bn, caffeNet, {bnName, scaleName})
end
conv = torchNet:get(7):get(1):get(1):get(2)
transTorch.toCaffe(conv, caffeNet, 'resc_L1_branch_conv1')

--block d
for i = 1, 3 do
    conv = torchNet:get(8):get(i):get(1):get(1):get(1)
    transTorch.toCaffe(conv, caffeNet, 'resd_L' .. i .. '_conv1')

    bn = torchNet:get(8):get(i):get(1):get(1):get(2)
    local bnName = 'resd_L' .. i .. '_bn1'
    local scaleName = 'resd_L' .. i .. '_scale1'
    transTorch.toCaffe(bn, caffeNet, {bnName, scaleName})

    conv = torchNet:get(8):get(i):get(1):get(1):get(4)
    transTorch.toCaffe(conv, caffeNet, 'resd_L' .. i .. '_conv2')

    bn = torchNet:get(8):get(i):get(1):get(1):get(5)
    local bnName = 'resd_L' .. i .. '_bn2'
    local scaleName = 'resd_L' .. i .. '_scale2'
    transTorch.toCaffe(bn, caffeNet, {bnName, scaleName})
end
conv = torchNet:get(8):get(1):get(1):get(2)
transTorch.toCaffe(conv, caffeNet, 'resd_L1_branch_conv1')

transTorch.writeCaffe(caffeNet, "resnet-34.caffemodel")

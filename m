Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9430B37346C
	for <lists+cgroups@lfdr.de>; Wed,  5 May 2021 06:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231380AbhEEEaB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 May 2021 00:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbhEEEaB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 5 May 2021 00:30:01 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8BBC061574
        for <cgroups@vger.kernel.org>; Tue,  4 May 2021 21:29:05 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id p4so1165798pfo.3
        for <cgroups@vger.kernel.org>; Tue, 04 May 2021 21:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=dkfLmEwUYBpgZ3VRNqk3l0eUK71c8qK9M3LO8M6K/A4=;
        b=j/2/x3IGENqBt1eM/uTRys9FwUAyOd7d1CPrhgnUeDqkdWgk208eetcKGgAwQm0ClS
         807Quye1hCoirriQHZ8jB6fGbUq8JRjgdvApCO7Sk2LBzgsemv98xXqPqhRBtNTYFbQ2
         c+pvRacMoE5zUBhZlKz1Zp/I3sP37UVPa/SyFRnF0O9Vv0+UUbY2fjviPRN77nwLubJm
         WkGzNUwF7P0ucQPk4Bw8kKF/DF8Lt/l4gAxFgApBd4DtEkMPmr//4N1veXHtU6pvce11
         I2Ygs6SMbnq3+EW7szo7yKB9Z6UagEOZuXHkUZLToFvlJwesJGEXi2KI7w4v+L0cFgNN
         jqBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dkfLmEwUYBpgZ3VRNqk3l0eUK71c8qK9M3LO8M6K/A4=;
        b=BsJF+qq5AgU8epxi7OE4T8DmO5k4WgCYrw+gGdohvMcs8zwT5YiXjaaVhzPgTI17Et
         boLkUt4FBl1esYSEkkN3ZT0fuvW2KcIZN19hLykgYZi813YlNYd0PBnM3ZMS0u4evnK7
         QuzXUQ/xteoOgJsIM+9VmXwgVfisjKWQuv5K7q/STm4KY1+kjpJN5eyEuFEKFU6cSh3H
         lNau9gkiKH9m8knSG1TbBd1hQmwPVwAJcF8PwHGgy2JwdiImKBkIB1wpfsKyBsaDaC8D
         y+Y4iMjqrXab8CA40vvbZr7GR4r9NCxHFjvrWUDntV6XVCEWP+O/3LVsKU/rQ3Jjj/Dr
         TYTQ==
X-Gm-Message-State: AOAM533fbNeAQNwms0/y7+eyxT2p2fYDH0ofTacojeVWxkd4ohQgVn4i
        qRu86NAvvnJqNN5cYXYESzewiA==
X-Google-Smtp-Source: ABdhPJwj5l+dKlySIdCGZk4hFYyrFl+frI0ecQuTkJrGFGr2OgKeAZLnUNmYF3pUR0T+bfW0S+MHsg==
X-Received: by 2002:aa7:8051:0:b029:272:7b9c:cde1 with SMTP id y17-20020aa780510000b02902727b9ccde1mr26211062pfm.55.1620188944813;
        Tue, 04 May 2021 21:29:04 -0700 (PDT)
Received: from localhost (ppp121-45-194-51.cbr-trn-nor-bras38.tpg.internode.on.net. [121.45.194.51])
        by smtp.gmail.com with UTF8SMTPSA id l6sm5170914pgc.68.2021.05.04.21.28.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 May 2021 21:29:04 -0700 (PDT)
Message-ID: <7e5c2276-ca1c-a8af-c15f-72a7c83c8bfa@ozlabs.ru>
Date:   Wed, 5 May 2021 14:28:53 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:88.0) Gecko/20100101
 Thunderbird/88.0
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and allocation
 APIs
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>,
        David Gibson <david@gibson.dropbear.id.au>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Auger Eric <eric.auger@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Raj, Ashok" <ashok.raj@intel.com>, "Wu, Hao" <hao.wu@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>
References: <20210421133312.15307c44@redhat.com>
 <20210421230301.GP1370958@nvidia.com> <20210422111337.6ac3624d@redhat.com>
 <YIeYJZOdgMN/orl0@yekko.fritz.box> <20210427172432.GE1370958@nvidia.com>
 <YIi5G4Wg/hpFqNdX@yekko.fritz.box> <20210429002149.GZ1370958@nvidia.com>
 <YIol9p3z8BTWFRh8@yekko> <20210503160530.GL1370958@nvidia.com>
 <YJDFj+sAv41JRIo4@yekko> <20210504181537.GC1370958@nvidia.com>
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
In-Reply-To: <20210504181537.GC1370958@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 05/05/2021 04:15, Jason Gunthorpe wrote:
> On Tue, May 04, 2021 at 01:54:55PM +1000, David Gibson wrote:
>> On Mon, May 03, 2021 at 01:05:30PM -0300, Jason Gunthorpe wrote:
>>> On Thu, Apr 29, 2021 at 01:20:22PM +1000, David Gibson wrote:
>>>>> There is a certain appeal to having some
>>>>> 'PPC_TCE_CREATE_SPECIAL_IOASID' entry point that has a wack of extra
>>>>> information like windows that can be optionally called by the viommu
>>>>> driver and it remains well defined and described.
>>>>
>>>> Windows really aren't ppc specific.  They're absolutely there on x86
>>>> and everything else as well - it's just that people are used to having
>>>> a window at 0..<something largish> that you can often get away with
>>>> treating it sloppily.
>>>
>>> My point is this detailed control seems to go on to more than just
>>> windows. As you say the vIOMMU is emulating specific HW that needs to
>>> have kernel interfaces to match it exactly.
>>
>> It's really not that bad.  The case of emulating the PAPR vIOMMU on
>> something else is relatively easy, because all updates to the IO page
>> tables go through hypercalls.  So, as long as the backend IOMMU can
>> map all the IOVAs that the guest IOMMU can, then qemu's implementation
>> of those hypercalls just needs to put an equivalent mapping in the
>> backend, which it can do with a generic VFIO_DMA_MAP.
> 
> So you also want the PAPR vIOMMU driver to run on, say, an ARM IOMMU?


This is a good feature in general when let's say there is a linux 
supported device which has a proprietary device firmware update tool 
which only exists as an x86 binary and your hardware is not x86 - 
running qemu + vfio in full emulation would provide a way to run the 
tool to update a physical device.


-- 
Alexey

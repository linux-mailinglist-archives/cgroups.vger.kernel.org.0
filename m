Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 719CF746B3A
	for <lists+cgroups@lfdr.de>; Tue,  4 Jul 2023 09:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbjGDHzS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 4 Jul 2023 03:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbjGDHzJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 4 Jul 2023 03:55:09 -0400
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233A710CC
        for <cgroups@vger.kernel.org>; Tue,  4 Jul 2023 00:54:47 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-4fb90f72062so1270099e87.0
        for <cgroups@vger.kernel.org>; Tue, 04 Jul 2023 00:54:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688457273; x=1691049273;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fWG6yfCA3V3Tdfob5HbNNseG8GZJElIvt+EDZjnECA8=;
        b=RCemUsjg+7DjJopTmFDf3pUVm3NWzaPoR6FsvmSSYZsEArCp/ijMXn8qz/z3UKHH3q
         34xTQWA+VGfmZAcuDQWnqRwPfJsTTS0SM522/RIHxWOYTi62wVZD+dlleBoXAHud1z22
         f8FhiV4IS9ppK1wLqznMTr2I60quRIofNxUUz9j59QwLULXgXh+LAqn8wmE9D9VPwE95
         fOzPOP1DqwMWu19yxNh+IW3cxEnNFT7iblcDNffzLbGoas7qHEd7UWDPtDBhda5O6xv2
         oj87gwV3pBcCZu5hGJ30MSB4YBIdwl7L21wbk8286bRIz5rEQ92t2HpoL7ykzJV/iQzw
         TRaA==
X-Gm-Message-State: ABy/qLY4D+MDTsNpGB/HCB5UE4/S4n/EfQpKyHnl88nfWgPXg4hdRqdk
        vQH221+obEj8PgD7vkaSQwk=
X-Google-Smtp-Source: APBJJlHEl6sIR9YgO8cmzCcJZEnPPYatLGhl1VaqgU5lEb3DN3zwJhel3eNK9jVgpkANWurQuhjSBQ==
X-Received: by 2002:a19:ee0e:0:b0:4f8:6ab4:aac6 with SMTP id g14-20020a19ee0e000000b004f86ab4aac6mr6501972lfb.1.1688457272970;
        Tue, 04 Jul 2023 00:54:32 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id l4-20020adfe9c4000000b0031435c2600esm5524082wrn.79.2023.07.04.00.54.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 00:54:32 -0700 (PDT)
Message-ID: <b181b848-b2c7-4a7e-7173-ff6c771d6731@grimberg.me>
Date:   Tue, 4 Jul 2023 10:54:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] nvmet: allow associating port to a cgroup via configfs
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     Ofir Gal <ofir.gal@volumez.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "hch@lst.de" <hch@lst.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        cgroups@vger.kernel.org
References: <20230627100215.1206008-1-ofir.gal@volumez.com>
 <30d03bba-c2e1-7847-f17e-403d4e648228@grimberg.me>
 <90150ffd-ba2d-6528-21b7-7ea493cd2b9a@nvidia.com>
 <79894bd9-03c7-8d27-eb6a-5e1336550449@volumez.com>
 <ab204a2d-9a30-7c90-8afa-fc84c935730f@grimberg.me>
 <ZKMehaAF0v-nV1qt@slm.duckdns.org>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZKMehaAF0v-nV1qt@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


>>> A full blown nvmet cgroup controller may be a complete solution, but it
>>> may take some time to achieve,
>>
>> I don't see any other sane solution here.
>>
>> Maybe Tejun/others think differently here?
> 
> I'm not necessarily against the idea of enabling subsystems to assign cgroup
> membership to entities which aren't processes or threads. It does make sense
> for cases where a kernel subsystem is serving multiple classes of users
> which aren't processes as here and it's likely that we'd need something
> similar for certain memory regions in a limited way (e.g. tmpfs chunk shared
> across multiple cgroups).

That makes sense.

 From the nvme target side, the prime use-case is I/O, which can be on
against bdev backends, file backends or passthru nvme devices.

What we'd want is for something that is agnostic to the backend type
hence my comment that the only sane solution would be to introduce a
nvmet cgroup controller.

I also asked the question of what is the use-case here? because the
"users" are remote nvme hosts accessing nvmet, there is no direct
mapping between a nvme namespace (backed by say a bdev) to a host, only
indirect mapping via a subsystem over a port (which is kinda-sorta
similar to a SCSI I_T Nexus). Implementing I/O service-levels
enforcement with blkcg seems like the wrong place to me.

> That said, because we haven't done this before, we haven't figured out how
> the API should be like and we definitely want something which can be used in
> a similar fashion across the board. Also, cgroup does assume that resources
> are always associated with processes or threads, and making this work with
> non-task entity would require some generalization there. Maybe the solution
> is to always have a tying kthread which serves as a proxy for the resource
> but that seems a bit nasty at least on the first thought.

That was also a thought earlier in the thread as that is pretty much
what the loop driver does, however that requires quite a bit of
infrastructure because nvmet threads are primarily workqueues/kworkers,
There is no notion of kthreads per entity.

> In principle, at least from cgroup POV, I think the idea of being able to
> assign cgroup membership to subsystem-specific entities is okay. In
> practice, there are quite a few challenges to address.

Understood.

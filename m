Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4D94D19BA
	for <lists+cgroups@lfdr.de>; Tue,  8 Mar 2022 14:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347257AbiCHN4l (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 8 Mar 2022 08:56:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236514AbiCHN4l (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 8 Mar 2022 08:56:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9C07D49F87
        for <cgroups@vger.kernel.org>; Tue,  8 Mar 2022 05:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646747743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1IBDuOS2fA0Ut8e4IiZznBpFVrC7yMpgLFek2NZWFfs=;
        b=T9jdB2dl3v0/ZLlYNeb/oV5yazRPOl3B0PMh7i0TVzuoN7zaGGMzmOc9so1ojgD0wqGcD+
        73HiKHAH3CxBWesrCftjhqI6Wv5YuDHTTBFMd8aUBltsxyeQZ9DTiwLUM+rgvpkVKqrOlv
        DQc7v2LxRtC0qDkT72WjrIYEU9Dt6VY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-281-SuU8-e6JOCKrP9vENW0Mmw-1; Tue, 08 Mar 2022 08:55:42 -0500
X-MC-Unique: SuU8-e6JOCKrP9vENW0Mmw-1
Received: by mail-ed1-f70.google.com with SMTP id r8-20020aa7d588000000b00416438ed9a2so4178406edq.11
        for <cgroups@vger.kernel.org>; Tue, 08 Mar 2022 05:55:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1IBDuOS2fA0Ut8e4IiZznBpFVrC7yMpgLFek2NZWFfs=;
        b=XESp2fW6lbqC3Ti7Ded6p1Eg3CTvDjji+V9TUVJK+SxUnHbFBf/ggjgUn47AL9wPBz
         bk7e0z3Whnm52YnI8L3o+MvMVk1g580GYcaoNSt8hB8j5PAN4VA3OcD9qIW2QcgwssoT
         MKB0M3VbAs67DcaejC9po4HTuHie+HB7bhIp+EGEPH51tkzfgy5iFYurMBXhI4YZBNEi
         hUorLtIjOsothpk8k4g3aLOZjMK5PUc7ZMCJBzukZsEDILOhuy8/E9FYuUPYZidyuy/m
         D2hAamikaojV8lKeXVqnJ3fn7U1g58mf3UBzQ7v7W7AgGybUNP/4MWYfWFXpLlAt0bmc
         vi6A==
X-Gm-Message-State: AOAM531MBD4KUt27E6+Oko1XwiiTpcPgJ3veqLF5XSw+5oNVEHAYrtov
        YrhHO2tDWOXUwEHaU3D+8qLeaPtRramQJ6Vol+k0NMXxvddpQDD3RDRkyH+wWhAXSxklRSBuRLO
        x1hnOIr661rFXbrdomA==
X-Received: by 2002:a17:907:72c5:b0:6da:e99e:226c with SMTP id du5-20020a17090772c500b006dae99e226cmr13706562ejc.515.1646747741391;
        Tue, 08 Mar 2022 05:55:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz6WmZv3/KHM1kx7+bdzcMlRqoo8+XkXcFt2ZUztmnvExDivbuO3SMLPcZhEKvKFLdILNTj/A==
X-Received: by 2002:a17:907:72c5:b0:6da:e99e:226c with SMTP id du5-20020a17090772c500b006dae99e226cmr13706551ejc.515.1646747741189;
        Tue, 08 Mar 2022 05:55:41 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id n9-20020a05640205c900b00415fbbdabbbsm6684307edx.9.2022.03.08.05.55.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 05:55:40 -0800 (PST)
Message-ID: <77a34051-2672-88cf-99dd-60f5acfb905e@redhat.com>
Date:   Tue, 8 Mar 2022 14:55:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/3] mm: vmalloc: introduce array allocation functions
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, stable@vger.kernel.org
References: <20220308105918.615575-1-pbonzini@redhat.com>
 <20220308105918.615575-2-pbonzini@redhat.com>
 <Yidefp4G/Hk2Twfy@dhcp22.suse.cz>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <Yidefp4G/Hk2Twfy@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 3/8/22 14:47, Michal Hocko wrote:
> Seems useful
> Acked-by: Michal Hocko<mhocko@suse.com>
> 
> Is there any reason you haven't used __alloc_size(1, 2) annotation?

It's enough to have them in the header:

>> +extern void *__vmalloc_array(size_t n, size_t size, gfp_t flags) __alloc_size(1, 2);
>> +extern void *vmalloc_array(size_t n, size_t size) __alloc_size(1, 2);
>> +extern void *__vcalloc(size_t n, size_t size, gfp_t flags) __alloc_size(1, 2);
>> +extern void *vcalloc(size_t n, size_t size) __alloc_size(1, 2);

Thanks for the quick review!

Paolo


Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C79D3696C0F
	for <lists+cgroups@lfdr.de>; Tue, 14 Feb 2023 18:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjBNRxo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Feb 2023 12:53:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbjBNRxn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 Feb 2023 12:53:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1D62734
        for <cgroups@vger.kernel.org>; Tue, 14 Feb 2023 09:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676397173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3wcl/mIBo22eXMS7cK2NpuJ4cYApHgRaBD0p8jlitp0=;
        b=RS9Dr3zecbarxBoEUEzJq1v2BXuP/zg37qK8qwwiyyu3J/zkdBWk+1Gi9BTUwqk+P7VSy1
        DXsmIEnA5BAO2rNdVL1X/2mm/d9ZaPt/J11M5fgxgHYODllwBr2hUajo0cuOQoEp6HdIae
        MLOPgLSn9K6I+gKpe5Fdui2nUA5NajE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-502-EGZTmec5NcSvKLUysN52DQ-1; Tue, 14 Feb 2023 12:52:52 -0500
X-MC-Unique: EGZTmec5NcSvKLUysN52DQ-1
Received: by mail-wm1-f70.google.com with SMTP id x10-20020a05600c21ca00b003dc5584b516so11309700wmj.7
        for <cgroups@vger.kernel.org>; Tue, 14 Feb 2023 09:52:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3wcl/mIBo22eXMS7cK2NpuJ4cYApHgRaBD0p8jlitp0=;
        b=B3jp3NfrcB0sWwgqW8VM5QMoq1rFuDW4KrQyTltsxTBne/NxqHu06AVWtp5sx8O8J1
         RPSINrz4bpCnkBdVUzw0btQKFfteD1zvaBHh3hnbNGiA+dA9c1ncqVxm31TLKx1n9/Ch
         fwyot5jaMFY1lBgxN6Wt+RE3r+4BbKJaTeaVgZbYHi20r0HZFjmvJLm1Ec6MFxcfqP9v
         5ql5ZvRdwOXyBcozO6vcnW/i0tItAGk8aL3cFMD/WH/6P6QH3unfpAVonrUmEeOifBvk
         Ae9N+dj7jmd+xig3Aj3hVsvygT3tSIRQ5hcJl1XBdLwLo2P4L4FMspyWwdFAI9+f9jS/
         mAKw==
X-Gm-Message-State: AO0yUKW6CQFADV2o1GjYli6EGGhGoFb/btGW8sGp09m7NDGhymXtLi3b
        1fkokqT6A8UkkxP//57uIqegsmxPud0wXxvHJ6ieKKE4p3Iwl7b3+bBNFMl9rrfVsaRcbQunucx
        a73I2gogFpqAFe1pcMw==
X-Received: by 2002:a05:600c:1810:b0:3df:e6bb:768 with SMTP id n16-20020a05600c181000b003dfe6bb0768mr2663866wmp.24.1676397171494;
        Tue, 14 Feb 2023 09:52:51 -0800 (PST)
X-Google-Smtp-Source: AK7set+ibnmq4kcT8UCovLoaG/wupL1YfMy0JvPMHkpSzCbHZJ4rAhXM0UWak5dYU0hGHDSdoPp/vg==
X-Received: by 2002:a05:600c:1810:b0:3df:e6bb:768 with SMTP id n16-20020a05600c181000b003dfe6bb0768mr2663847wmp.24.1676397171263;
        Tue, 14 Feb 2023 09:52:51 -0800 (PST)
Received: from ?IPV6:2003:cb:c709:1700:969:8e2b:e8bb:46be? (p200300cbc709170009698e2be8bb46be.dip0.t-ipconnect.de. [2003:cb:c709:1700:969:8e2b:e8bb:46be])
        by smtp.gmail.com with ESMTPSA id l19-20020a05600c2cd300b003dfefe115b9sm19847507wmc.0.2023.02.14.09.52.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 09:52:50 -0800 (PST)
Message-ID: <5064ee08-792f-14f2-6f2d-26e81af8a239@redhat.com>
Date:   Tue, 14 Feb 2023 18:52:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 0/4] Change the return value for page isolation
 functions
Content-Language: en-US
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        akpm@linux-foundation.org
Cc:     torvalds@linux-foundation.org, sj@kernel.org, hannes@cmpxchg.org,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, naoya.horiguchi@nec.com,
        linmiaohe@huawei.com, osalvador@suse.de, mike.kravetz@oracle.com,
        willy@infradead.org, damon@lists.linux.dev,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cover.1676382188.git.baolin.wang@linux.alibaba.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <cover.1676382188.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 14.02.23 14:59, Baolin Wang wrote:
> Now the page isolation functions did not return a boolean to indicate
> success or not, instead it will return a negative error when failed
> to isolate a page. So below code used in most places seem a boolean
> success/failure thing, which can confuse people whether the isolation
> is successful.
> 
> if (folio_isolate_lru(folio))
>          continue;
> 
> Moreover the page isolation functions only return 0 or -EBUSY, and
> most users did not care about the negative error except for few users,
> thus we can convert all page isolation functions to return a boolean
> value, which can remove the confusion to make code more clear.
> 
> No functional changes intended in this patch series.
> 
> Changes from v1:
>   - Convert all isolation functions to return bool.

Acked-by: David Hildenbrand <david@redhat.com>

Although it's controversial if

if (!ret)
	ret = -EBUSY;
else
	ret = 0;

is really appealing to the readers eye :)

ret = ret ? 0 : -EBUSY;

It's still confusing.

would be better as

ret = isolated ? 0 : -EBUSY;

IOW, not reusing the "int ret" variable.

-- 
Thanks,

David / dhildenb


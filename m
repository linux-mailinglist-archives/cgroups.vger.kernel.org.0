Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6E079C2B6
	for <lists+cgroups@lfdr.de>; Tue, 12 Sep 2023 04:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235801AbjILCZR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 11 Sep 2023 22:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236447AbjILCZG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 11 Sep 2023 22:25:06 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8EB3116B0B;
        Mon, 11 Sep 2023 18:49:12 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c39a4f14bcso22387805ad.3;
        Mon, 11 Sep 2023 18:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694483352; x=1695088152; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4C6fCAbfQ04p8mFbrpL2ZAAFU2CUe5VETqkFVwtItV8=;
        b=mQgVeNINuE+EX8YyL7/+XZvVpEbnTI6QKJZVbshrNIr330wsnRKU0p+iMqcdprnJCb
         gcaznEY8HYc1K6p97adQXiTMuZhHSVm73GsfHqaoLfU1r2keKhOOjZeSYa2KJifevH8V
         cCiWRJ/W4kURpU6TUoDCah2re1zYZkSxZHKQORcXWMJfOMg1XPSu1I8n9Kf4TjCeohkM
         zFCiI8UvaIztZpX42dY1swbmoI1OJ51NA4PHkz65F1NP6WpPZhObwUXe3Ik5frnptnHY
         Fh7mLNv38fUZolPANf7OUpWr89lyKImnyruYj0KgmoVQ0bVWrqKfxaKtFxZmuYbfXeL+
         tEQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694483352; x=1695088152;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4C6fCAbfQ04p8mFbrpL2ZAAFU2CUe5VETqkFVwtItV8=;
        b=dwQYiTje095t4HRp27zFw9LuxGVhbr2AA+iBkeOK+a/JUcOf+UuUkcWySMgtAZeSiE
         B2m3pD1r9b8HabZGctviSYKw+f+vOgROXcjccQCbw4tSSuQrpWGqLiObmm32iWxYW8TO
         cuKkiOptB8u/qY6KPk7VwoiMUz1GwV72HYmPowNXmAetz1lnxf/XLGGKloRDIb1asHbE
         /bmp5JuRbKyoS/FEdbyWuBiU3kzG1QOZzfMQqr979Cixfng66NJl/VfJN6CjppahIo4H
         n2JMEnlGRQ4xDm2a7dpsN+HiMq86NhHCZoxDjTZweyqYGRhYENzNXGOn1a3SVHvtQaIz
         werQ==
X-Gm-Message-State: AOJu0Yz9wPeCTFniCw63tImjLRmClQ1gg6SJuOBxI/JlR5ZDF6pgM6a9
        W8YDUkH9FueF1b/Gsua2OByxwnxsJXVJpg==
X-Google-Smtp-Source: AGHT+IGVYjG3N6xVMjxqCoTiiJoeOMMyzd6MFy06jlIH1Xgq48nNfB+PxN+XfZvjb+AdQK1tZEGjpQ==
X-Received: by 2002:a17:902:db11:b0:1bc:61d6:5fcc with SMTP id m17-20020a170902db1100b001bc61d65fccmr14277093plx.51.1694483352171;
        Mon, 11 Sep 2023 18:49:12 -0700 (PDT)
Received: from [192.168.255.10] ([103.7.29.31])
        by smtp.gmail.com with ESMTPSA id g22-20020a170902869600b001bdc3768ca5sm7138187plo.254.2023.09.11.18.49.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 18:49:11 -0700 (PDT)
Message-ID: <6b0447d0-30c7-4432-a4f3-97e2d27e9e3b@gmail.com>
Date:   Tue, 12 Sep 2023 09:49:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: memcg: add THP swap out info for anonymous reclaim
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230909155242.22767-1-vernhao@tencent.com>
 <20230911160824.GB103342@cmpxchg.org>
From:   Vern Hao <haoxing990@gmail.com>
In-Reply-To: <20230911160824.GB103342@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


在 2023/9/12 00:08, Johannes Weiner 写道:
> On Sat, Sep 09, 2023 at 11:52:41PM +0800, Xin Hao wrote:
>> At present, we support per-memcg reclaim strategy, however we do not
>> know the number of transparent huge pages being reclaimed, as we know
>> the transparent huge pages need to be splited before reclaim them, and
>> they will bring some performance bottleneck effect. for example, when
>> two memcg (A & B) are doing reclaim for anonymous pages at same time,
>> and 'A' memcg is reclaiming a large number of transparent huge pages, we
>> can better analyze that the performance bottleneck will be caused by 'A'
>> memcg.  therefore, in order to better analyze such problems, there add
>> THP swap out info for per-memcg.
>>
>> Signed-off-by: Xin Hao <vernhao@tencent.com>
> That sounds reasonable. A few comments below:
>
>> @@ -4131,6 +4133,10 @@ static const unsigned int memcg1_events[] = {
>>   	PGPGOUT,
>>   	PGFAULT,
>>   	PGMAJFAULT,
>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> +	THP_SWPOUT,
>> +	THP_SWPOUT_FALLBACK,
>> +#endif
>>   };
> Cgroup1 is maintenance-only, please drop this hunk.
Will remove it next version thanks.
>
>>   static void memcg1_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
>> diff --git a/mm/page_io.c b/mm/page_io.c
>> index fe4c21af23f2..008ada2e024a 100644
>> --- a/mm/page_io.c
>> +++ b/mm/page_io.c
>> @@ -208,8 +208,10 @@ int swap_writepage(struct page *page, struct writeback_control *wbc)
>>   static inline void count_swpout_vm_event(struct folio *folio)
>>   {
>>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> -	if (unlikely(folio_test_pmd_mappable(folio)))
>> +	if (unlikely(folio_test_pmd_mappable(folio))) {
>> +		count_memcg_events(folio_memcg(folio), THP_SWPOUT, 1);
> count_memcg_folio_events()
Done.
>
>>   		count_vm_event(THP_SWPOUT);
>> +	}
>>   #endif
>>   	count_vm_events(PSWPOUT, folio_nr_pages(folio));
>>   }
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index ea57a43ebd6b..29a82b72345a 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -1928,6 +1928,8 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>>   								folio_list))
>>   						goto activate_locked;
>>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> +					count_memcg_events(folio_memcg(folio),
>> +							   THP_SWPOUT_FALLBACK, 1);
> count_memcg_folio_events()

Done.

thanks.


Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 583556A2ECE
	for <lists+cgroups@lfdr.de>; Sun, 26 Feb 2023 09:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbjBZH7y (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 26 Feb 2023 02:59:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBZH7y (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 26 Feb 2023 02:59:54 -0500
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62E2C65C;
        Sat, 25 Feb 2023 23:59:51 -0800 (PST)
Received: by mail-wm1-f46.google.com with SMTP id o11-20020a05600c4fcb00b003eb33ea29a8so1537864wmq.1;
        Sat, 25 Feb 2023 23:59:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DGCngb9cE5yE6M3a4MEomrCzATYJDSH8ymK+LBwgxOM=;
        b=ONF4gXqPLX71AvJCCqRoiH0k1+wIcJTtekmSM4T92mrL6mjklpVgtJUAyWAF3BU5c+
         ktbMVgqoj/p3AX4JXOr7UXHQA+b6NTeuk8+oOL9eLrb9SzznMdnjogCTWAylHXejtQlq
         QJKDE45bGYm/N2l+wWmBZuHqp/0nhUBIU/sc/js09GHfDca/7isJM3osKgS5+M69gty6
         C/6oDp1492+mxUISZqL85nh8Y4i8AtczEHJ+Yr5lL9hD/fFu4jAxGBYoxuhfOUVIOALF
         HllvKQjwcHa/GEg8Iopsv9gz/Uy1P4gh7m5iDKJyf1eFawwzfQi1fwmZPdFv5hfW5yki
         2c8w==
X-Gm-Message-State: AO0yUKWr7j14CrfI55WyqvGZMxTZ0Sn42eXG+H9P5koU2TBmvZ9x73q8
        td0bE+VDrPj8eMQHCwdisfU=
X-Google-Smtp-Source: AK7set9unaczVbzdJ61bhZUDAp9ZSY4c0yfMIwvnYMtDVvtvVCPDBk6Sw9xH6RsTakaisDcD5DxDww==
X-Received: by 2002:a05:600c:1895:b0:3e2:f80:3df1 with SMTP id x21-20020a05600c189500b003e20f803df1mr15890132wmp.19.1677398389950;
        Sat, 25 Feb 2023 23:59:49 -0800 (PST)
Received: from [10.1.0.47] ([87.224.71.110])
        by smtp.gmail.com with ESMTPSA id l4-20020a05600c4f0400b003df7b40f99fsm9261670wmq.11.2023.02.25.23.59.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Feb 2023 23:59:49 -0800 (PST)
Message-ID: <3130cb3e-eaca-04c2-ad97-b32ffddad397@debian.org>
Date:   Sun, 26 Feb 2023 07:59:48 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH] blk-iocost: initialize rqos before accessing it
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     axboe@kernel.dk, tj@kernel.org, josef@toxicpanda.com,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        aherrmann@suse.de, linux-kernel@vger.kernel.org, hch@lst.de,
        leit@fb.com
References: <20230224160714.172884-1-leitao@debian.org>
 <20230224185126.bxkreilofbp2t4on@blackpad>
Content-Language: en-US
From:   Breno Leitao <leitao@debian.org>
In-Reply-To: <20230224185126.bxkreilofbp2t4on@blackpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello Michal,

On 2/24/23 18:51, Michal Koutný wrote:
>> 	blk_iocost_init (include/asm-generic/qspinlock.h:128
>> 			 include/linux/spinlock.h:203
>> 			 include/linux/spinlock_api_smp.h:158
>> 			 include/linux/spinlock.h:400
>> 			 block/blk-iocost.c:2884)
>> 	ioc_qos_write (block/blk-iocost.c:3198)
>> 	? kretprobe_perf_func (kernel/trace/trace_kprobe.c:1566)
>> 	? kernfs_fop_write_iter (include/linux/slab.h:584 fs/kernfs/file.c:311)
>> 	? __kmem_cache_alloc_node (mm/slab.h:? mm/slub.c:3452 mm/slub.c:3491)
>> 	? _copy_from_iter (arch/x86/include/asm/uaccess_64.h:46
>> 			   arch/x86/include/asm/uaccess_64.h:52
>> 			   lib/iov_iter.c:183 lib/iov_iter.c:628)
>> 	? kretprobe_dispatcher (kernel/trace/trace_kprobe.c:1693)
>> 	cgroup_file_write (kernel/cgroup/cgroup.c:4061)
>> 	kernfs_fop_write_iter (fs/kernfs/file.c:334)
>> 	vfs_write (include/linux/fs.h:1849 fs/read_write.c:491
>> 		   fs/read_write.c:584)
>> 	ksys_write (fs/read_write.c:637)
>> 	do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80)
>> 	entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120)
> 
> BTW, out of curiosity what tool did you use to list stack with line
> numbers?

I use the decode_stacktrace.sh from kernel's scripts directory. You 
basically
pipe the stack to it, and call it passing the vmlinux file. It is 
incredible handy.

https://elixir.bootlin.com/linux/latest/source/scripts/decode_stacktrace.sh

Thanks for the review,
Breno

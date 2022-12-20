Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C681565240A
	for <lists+cgroups@lfdr.de>; Tue, 20 Dec 2022 17:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiLTQBg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 20 Dec 2022 11:01:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233220AbiLTQBd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 20 Dec 2022 11:01:33 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95BCC38A5;
        Tue, 20 Dec 2022 08:01:32 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id fy4so12887523pjb.0;
        Tue, 20 Dec 2022 08:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CZMmU+pGQ8I5cymzBUpFRodcntV5ODz7Rjd+p+IjcxM=;
        b=FgJB7RQvMGsU5maNwk7Ibn2Kug3rClLlbV+23BVAoBFTwzYdicUZXx3BxJFCWZACEC
         POblY96MELR7T8nVNu6GLXbVj3mdBhx9OWg+ZlzMjrulDNLSzZubdpBOCyAOuYAk1GLg
         6rEUYa4jn5ws84VoWzD+jGpalbsPbcEv6MtfvQfmUe3Bwh0ZymytgdtxzCe4SAxSrrZW
         JRsTSU42YJ8g0PZRLD5Dt3rOnvuYZyElq0JPi8DYrCTyyg7ARVSRAGy7Z5/+NF+zqMkJ
         O+XjDFoi/9ao4U8frNn+BxeKGEMMB+OkJytTxfidyNroPX4BqWLhwMp6/SNiMJGUxwc6
         GPyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CZMmU+pGQ8I5cymzBUpFRodcntV5ODz7Rjd+p+IjcxM=;
        b=HIbvMRIRuWcK9mtq2UIMCz89ZoSubGN75W0cfLi5N4PQqXumfYyaBLaD7hVr9YmTUq
         vKob0wknlACA4esasc7l2krq9OU9opAyKlDhKoAgStdokhv4T5G9B0s9qplBPVVwyJ13
         fzd/jqE3iVDQP/66WCXo0Iw8ou/gLkO7WCjzusZ8JuzKv0ioxA9xAZS4q/UgmavG/tHl
         h52H7b5PbUIUD5MmT8mhkLSpB3UaoGMgj4W5AAne4/dTeJ2+sjcFdHf7MFgdSG4b0nQB
         VW/M34cIloYn9PIMXVDPimxNlHKU6yAMcs5cJXRfbiE/ZYQqG2YYC6CDGJq76QND8kH0
         LMdA==
X-Gm-Message-State: AFqh2kq8lqQ3gSoZTzZKgC3pKwIsvRDpMMhA7bdePJnZr9FjsPzhOKn8
        mDTQArYpjDx2avZZt/lLW0s=
X-Google-Smtp-Source: AMrXdXu/PTWG3RF5FJl77akOeoAMUXeZltzVrigzm8q6ibeY4U1MWMGr6FwSCANfZHn/XMjGC92vWg==
X-Received: by 2002:a05:6a20:d385:b0:b0:3318:ab59 with SMTP id iq5-20020a056a20d38500b000b03318ab59mr12279097pzb.14.1671552091976;
        Tue, 20 Dec 2022 08:01:31 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id 64-20020a620543000000b00574b86040a4sm8846432pff.3.2022.12.20.08.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 08:01:31 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 20 Dec 2022 06:01:30 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     hch@infradead.org, josef@toxicpanda.com, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH -next 0/4] blk-cgroup: synchronize del_gendisk() with
 configuring cgroup policy
Message-ID: <Y6HcWiJbaWjN3jlt@slm.duckdns.org>
References: <20221217030908.1261787-1-yukuai1@huaweicloud.com>
 <Y6DP3aOSad8+D1yY@slm.duckdns.org>
 <e01daffe-a3e3-8bf2-40ee-192a9e70d911@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e01daffe-a3e3-8bf2-40ee-192a9e70d911@huaweicloud.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Tue, Dec 20, 2022 at 05:19:12PM +0800, Yu Kuai wrote:
> Yes, that sounds good. BTW, queue_lock is also used to protect
> pd_alloc_fn/pd_init_fn，and we found that blkcg_activate_policy() is
> problematic:
> 
> blkcg_activate_policy
>  spin_lock_irq(&q->queue_lock);
>  list_for_each_entry_reverse(blkg, &q->blkg_list
>   pd_alloc_fn(GFP_NOWAIT | __GFP_NOWARN,...) -> failed
> 
>   spin_unlock_irq(&q->queue_lock);
>   // release queue_lock here is problematic, this will cause
> pd_offline_fn called without pd_init_fn.
>   pd_alloc_fn(__GFP_NOWARN,...)

So, if a blkg is destroyed while a policy is being activated, right?

> If we are using a mutex to protect rq_qos ops, it seems the right thing
> to do do also using the mutex to protect blkcg_policy ops, and this
> problem can be fixed because mutex can be held to alloc memroy with
> GFP_KERNEL. What do you think?

One worry is that switching to mutex can be more headache due to destroy
path synchronization. Another approach would be using a per-blkg flag to
track whether a blkg has been initialized.

Thanks.

-- 
tejun

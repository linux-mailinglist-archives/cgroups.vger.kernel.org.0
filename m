Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1395166A0B4
	for <lists+cgroups@lfdr.de>; Fri, 13 Jan 2023 18:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbjAMR2Q (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 13 Jan 2023 12:28:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjAMR1h (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 13 Jan 2023 12:27:37 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F71820DC;
        Fri, 13 Jan 2023 09:16:16 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id q64so23037933pjq.4;
        Fri, 13 Jan 2023 09:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=52MNpdUJgF3+oIlWggDDfrxPPD9Ztp6sCT03jqLjxgI=;
        b=qoUH+lwlmFLafVPNtyZsi5g+/lFmY4VRICVR8nxpfZhir2UA9+ZTFVSHv+aWHGONgc
         prVifwhDZCRV7oQCr4MZQ5QVlmQFFdwuzZLzjKHmn4QCNEXbKj7Cy0Fdsv86hLM5l/pi
         oT7ITQFfR39idU7/bOxREINUvmmagDFYP136gv8nIIUarzMSDfpAK54f5xmEWMH88iEj
         X2gTJ4rdxMOuLkRlsUeaLFdN/vX01WRDAfvjOsO2FkaL/sN5xX3K039opZjKA08lXh8E
         vcQ7X2mwFgpX7DvPYjhRZ5d+/IAt+3QxtgfHvI3o/dEEvRQw2nigPv6L/aUng/Kf9Rlp
         fExA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=52MNpdUJgF3+oIlWggDDfrxPPD9Ztp6sCT03jqLjxgI=;
        b=H/FNNin8ThBdeltrsi+mMuuQ+blU68a32o+ZbbOr63olGLcbdEILiMTJ/osYuRa7hf
         hnv7H6x0rrNB1LSwb54L0DnyxC4nu9Ws+wLM163jsw9sapVAfzcl2kIFWQ9gNqw3wHX6
         nOGNxA3b4Ih8jwrWfQoUbXiuxnVHzxyDq8qGlSzolryq509+kZcaB/gwUi3rsp9Ov00E
         sLC8LauX6YyfW/VD0sZb6z2YhE/95m4Lop0ufc4G0GbjW7r2ywYThWYbjqSoXZE3FFH5
         WF+TjXPfUTJ/AxQdLbCVGLJMLRB60b/EhH7R4xetZT4qGcqLNSniZhARB8J6UfdZt3v4
         ihMg==
X-Gm-Message-State: AFqh2kokLCtnDAi8n3IgcqXwp+hjWP/A8NwEh/mVyGTAf/xXwpDgYnBe
        J61iMsG4JWb+6pyvenQchYEA8cfS/7s=
X-Google-Smtp-Source: AMrXdXsOb1/cz5idjSPHBBq+vj1mwFSPSnXMu9ltctsJRZDrbkxp8zVi6idyzHv+1TBw3SupYD9W2w==
X-Received: by 2002:a17:90a:9a89:b0:229:306b:6111 with SMTP id e9-20020a17090a9a8900b00229306b6111mr2039192pjp.20.1673630175811;
        Fri, 13 Jan 2023 09:16:15 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id z15-20020a17090a608f00b00225d7c0dc14sm14586012pji.28.2023.01.13.09.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 09:16:15 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 13 Jan 2023 07:16:13 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     hch@infradead.org, josef@toxicpanda.com, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH v2 1/2] blk-iocost: add refcounting for iocg
Message-ID: <Y8GR3V3RsdS+XYzh@slm.duckdns.org>
References: <Y7xbpidpq7+DqJan@slm.duckdns.org>
 <a71f997f-6cae-d57b-85dd-2fd499d238f6@huaweicloud.com>
 <Y72wF/b0/xNRmP7f@slm.duckdns.org>
 <53b30ac8-d608-ba0b-8b1b-7fe5cfed6d61@huaweicloud.com>
 <Y77s0f741mFfGlTO@slm.duckdns.org>
 <4aeef320-c6c8-d9b4-8826-d58f00ea6264@huaweicloud.com>
 <Y8CrloCDGhbU42OH@slm.duckdns.org>
 <efa1c73b-e94f-373f-e535-2cfc32ce2433@huaweicloud.com>
 <Y8CwwghZ0adMsHFC@slm.duckdns.org>
 <ac95dfb8-b1b6-8916-bde8-1edb573e7ca5@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac95dfb8-b1b6-8916-bde8-1edb573e7ca5@huaweicloud.com>
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

On Fri, Jan 13, 2023 at 09:25:11AM +0800, Yu Kuai wrote:
> I think hold the lock in blkg_free_workfn() is too late, pd_free_fn()
> for parent from blkcg_deactivate_policy() can be called first.
> 
> t1: remove cgroup t1/t2
> blkcg_destroy_blkgs
>  blkg_destroy
>   percpu_ref_kill(&blkg->refcnt)
>    blkg_release
>     blkg_free
>      schedule_work(&blkg->free_work)
>      // t1 is done
> 
> t2: handle t1 from removing device
> blkcg_deactivate_policy
>  pd_free_fn
>  // free parent
> 				t3: from t1
> 				blkg_free_workfn
> 				 pd_free_fn
> 				 // free child

As we discussed before, you'd have to order the actual freeing by shifting
the ref puts into the free_work. If you move `blkg_put(blkg->parent)` and
`list_del_init(&blkg->q_node)` to blkg_free_workfn() (this will require
adjustments as these things are used from other places too), the free work
items will be ordered and the blkg would remain iterable - IOW,
deactivate_policy would be able to see it allowing the two paths to
synchronize, right?

Thanks.

-- 
tejun

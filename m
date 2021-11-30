Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF8DB463BB9
	for <lists+cgroups@lfdr.de>; Tue, 30 Nov 2021 17:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243738AbhK3Q3k (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 30 Nov 2021 11:29:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239752AbhK3Q3j (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 30 Nov 2021 11:29:39 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2C9C061574;
        Tue, 30 Nov 2021 08:26:20 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id 8so21146419pfo.4;
        Tue, 30 Nov 2021 08:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=c5SAYFCCSK5GacjcTQ47eQM20SEI2kSoxxYyDX/fm7g=;
        b=WuEA+bpfKYR9NLIIrwBgv9GJy2Sqs3GbI0IIf9pwMJMXsSCI1YQlAwXknLH/wTYAJD
         iGJxHYd9gWOMumxRX60SU8m9X3a96QJvwABQJSaLk/UwYX0oTzfvE1+mD/pTCPZVc0wX
         nwyTRT6H3nMscuCpww4ouTekbvVnImtzQkpCVviTPQrvcD3++XkUgRUtDbtMgc7kfIOS
         v9YgrBcEvackhH95vp53qGHa4xAKTe1iz3Dcs5hW3xJm1hr3bo+M8kG/vVt5vEAtyGLx
         pvSMzYNsPvDpfVl30+ppF1Aec1+VsyI9Ru7Iz3AJ2tJGdoavpTMIp8Og6Cbz837agOq1
         KPdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=c5SAYFCCSK5GacjcTQ47eQM20SEI2kSoxxYyDX/fm7g=;
        b=JnJl4Y1JpgbmL+Xjl0/uNUm+a58z8sPdBTnsLwNVD8HE7LR2wUs3MtZhYKtDnzegJb
         38XljqFB1hZIBQeWtYU5Ei3FtzD8dXoqMmKFJbGo3VrJ27Rm3mw19gs5rCh1ud4tC/W1
         OsIXjtaVinTwcEt9uzPAJ7hbdWpmavX+LgVIgF4ceMu/j5YF4fBcsaq32C12m7oIcChI
         /CxqCjlg5Q0jMWUhb90dtVBkqZWgpPabwKji8M/gwfBSJE+q1DEtq0TmD+ksfAqM/FAO
         UtGOII/hK3CJQcBQThY4wR9y6eWGRuJ/QzuCX2755cKr7FB12qHEAOe6hcvMl/Na+PKT
         fOig==
X-Gm-Message-State: AOAM53375HM5BGH848UKM/vCJUDTQ2Fn3bNY/xPot426i7REu61tJx0N
        cEizeNijI7UGRklte6W8cQs=
X-Google-Smtp-Source: ABdhPJzkO44MwB9FWMocPI631L8m3xRRVHgB04ObRgITFxLjJHORH5qdg1/C4bh1hAr4YDR0Yy8zQA==
X-Received: by 2002:a05:6a00:15c5:b0:4a0:3c1:4f43 with SMTP id o5-20020a056a0015c500b004a003c14f43mr47791127pfu.33.1638289579628;
        Tue, 30 Nov 2021 08:26:19 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id p10sm20876523pff.173.2021.11.30.08.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 08:26:19 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 30 Nov 2021 06:26:18 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     hch@infradead.org, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH v2 2/2] block: cancel all throttled bios in del_gendisk()
Message-ID: <YaZQqjjygHGFEdbx@slm.duckdns.org>
References: <20211130011730.2584339-1-yukuai3@huawei.com>
 <20211130011730.2584339-3-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130011730.2584339-3-yukuai3@huawei.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Tue, Nov 30, 2021 at 09:17:30AM +0800, Yu Kuai wrote:
> +void blk_throtl_cancel_bios(struct request_queue *q)
> +{
> +	struct throtl_data *td = q->td;
> +	struct blkcg_gq *blkg;
> +	struct cgroup_subsys_state *pos_css;
> +	struct bio *bio;
> +	int rw;
> +
> +	rcu_read_lock();

So, all of the draining is being performed without holding the q lock, which
*might* be okay given that we're in the del_gendisk path but is likely risky
- ie. there can still be timers or whatever racing against it.

Thanks.

-- 
tejun

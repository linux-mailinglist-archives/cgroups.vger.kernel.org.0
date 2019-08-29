Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4256BA1F7A
	for <lists+cgroups@lfdr.de>; Thu, 29 Aug 2019 17:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbfH2Pnm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 29 Aug 2019 11:43:42 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40866 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727495AbfH2Pnm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 29 Aug 2019 11:43:42 -0400
Received: by mail-qt1-f196.google.com with SMTP id g4so4152152qtq.7;
        Thu, 29 Aug 2019 08:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CqwCR92AMmjVYXHP7t59EX+jlAdzhnsJr6HfrLhRRVM=;
        b=ODTqtLtVa7hDa2Czg8NAJLdKjgXn5m5qdq4KmSlV81udeaxSfT400wmfiGbSX/kI47
         wCjpbJZioV/O2MA8cGnsNP61pg5ZthxJK8GF+EEKQmibdoNljA9toPeRhz8bu/MhMzPq
         Wj97l7gcAViSokNRCrej0Q/RWHMrqtogGokMV15fuDkIa5DKDIzpUS8DlIGDPWtPrOop
         kWOP/l+E6TrsDiXSnIOOii7vaTlO6RNr56uuPqsYy49B7SkG5FBmtuiqN+BoD363oxyB
         RilTZSTV1CQICNIfrk2aQE0tOkRmbFdVDdDBK1hHlJysQvXDh6r1a3qngKk4Ql/gghR0
         CQFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=CqwCR92AMmjVYXHP7t59EX+jlAdzhnsJr6HfrLhRRVM=;
        b=Jm0Pu6WrMHTKfgI4mj4a+a81p/iiicq6t5cFcE8KR/22muePxBYUFbDXSwnfcbVcRb
         OrY3pr4NVROO34jKXpGZC4/p78waWYURqYDsleOA0MszJsOTvB6mnCaDJNeLbNiwLzGl
         YP4sSxcgKE4CWZSEdleS2eLzbq1sQGsAHJ+pw0JO8OKQbS7XsWtIUAHC8I8Ho8WnP6Co
         3gwG2F220LLMWqvnUkHSeJhkyH2jDPDlRbQiP/45Uc6fReCpOubP1xnAGswqJPP/J0rG
         +XQD2B6vHUdEwjuSYvEkNV0j5Kov+oWp7BgPtjV+Q53wgU5jxCWzZMB/CZYmbgUgigq0
         EMyg==
X-Gm-Message-State: APjAAAVeY4ekC0aaQW6cQ0tryVwk7BuzSz39IYj9Aph4kcFWoygaoam0
        I4t3NUoc/b1k2TfKCc5cRYQ=
X-Google-Smtp-Source: APXvYqyb8pkjLWnxIS6I0Zi8fRdzp0rfQPWYf4MGwsQRjVqj8I70gUzu84gh1zq6bCW5CJ1qIM9D6A==
X-Received: by 2002:ac8:3043:: with SMTP id g3mr10360219qte.37.1567093420826;
        Thu, 29 Aug 2019 08:43:40 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:7e32])
        by smtp.gmail.com with ESMTPSA id h4sm78499qtn.62.2019.08.29.08.43.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Aug 2019 08:43:40 -0700 (PDT)
Date:   Thu, 29 Aug 2019 08:43:38 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     axboe@kernel.dk, newella@fb.com, clm@fb.com, josef@toxicpanda.com,
        dennisz@fb.com, lizefan@huawei.com, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-team@fb.com, cgroups@vger.kernel.org
Subject: Re: [PATCH 07/10] blk-mq: add optional request->alloc_time_ns
Message-ID: <20190829154338.GT2263813@devbig004.ftw2.facebook.com>
References: <20190828220600.2527417-1-tj@kernel.org>
 <20190829082248.6464-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829082248.6464-1-hdanton@sina.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Thu, Aug 29, 2019 at 04:22:48PM +0800, Hillf Danton wrote:
> >  static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
> > -		unsigned int tag, unsigned int op)
> > +		unsigned int tag, unsigned int op, u64 alloc_time_ns)
> >  {
> >  	struct blk_mq_tags *tags = blk_mq_tags_from_data(data);
> >  	struct request *rq = tags->static_rqs[tag];
> > @@ -325,6 +325,9 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
> >  	RB_CLEAR_NODE(&rq->rb_node);
> >  	rq->rq_disk = NULL;
> >  	rq->part = NULL;
> > +#ifdef CONFIG_BLK_RQ_ALLOC_TIME
> 
> Not only matches start_time, but everal hunks may collapse into one
> if checking alloc_time is lifted up.
> 
> 	if (blk_queue_rq_alloc_time(rq->q))
> 		rq->alloc_time_ns = ktime_get_ns();
> 	else
> 		rq->alloc_time_ns = 0;

Can you please elaborate?  Lifted up where?

Thanks.

-- 
tejun

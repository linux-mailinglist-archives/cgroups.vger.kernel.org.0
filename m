Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C46A1A6B03
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2020 19:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732537AbgDMRIi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Apr 2020 13:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732216AbgDMRIg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Apr 2020 13:08:36 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5A7C0A3BDC;
        Mon, 13 Apr 2020 10:08:36 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id c63so10205175qke.2;
        Mon, 13 Apr 2020 10:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NFNHfE7F1rrYFA5HLaqChE2dtGQCPN6coS8rdPNSigI=;
        b=hMvMIFkUh4+zKif04z4ScUfhsqi7SEl+A+mrbPrruG/ETMUk9MSMbdQuV+ZR7jkh3N
         J0dtg9bsXCxgugxr47p9P970lB3mLeXEl1+dvVvePWz0RAdaz/HKS9DkxqtVRssfjzz3
         WsnPlYz8DMA4ziVwz9BT6kPhHkaQ8UbLHH2o2QrG37vg6K6zL+C9Ns0+E3cpCa5Yr6lg
         pz39Lh4j6AOWTYBZOFbnjAsgZLTLjjKlGPKFSXrK0D+nlVPiGu2cLa8a1KZImJ/aDOPm
         /ruh8zkhxm/8oyNqJEz8FUOmopUR6CjUyrxGuMhEJAdkGzvu14q107uAQLarg3nczumZ
         0XFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=NFNHfE7F1rrYFA5HLaqChE2dtGQCPN6coS8rdPNSigI=;
        b=MYBix4g1OLEFk4vUV9ZmyXEkFTVaWF2Y3H2BEr/PUps1PZS9L/4sU6uLFUJEkBXgdm
         sijL4nrE7bJRoRIYXHtvQSQ4HX64Q9azx6p3d3aHfocfwug56GylxJxCFlbRLXEXt826
         9oHKNux45oRaODMA3FxOLYK2Pha7FIieK6YBm0sLZNiklDmAZN1rAFpTM+V9+qChPmiH
         MyLD9zggnWn52k0+XQm45Z+QvgUvIwES/r/7FHi2Cu2b6zWPTeMSAB1ts7LjjZcUky+l
         UvSrRZLEXQC733WBRCqlCM2YlakDRO0M8FUEvMFnETaV+a1ExeeyKO09io3oLEttfvTO
         Wh8A==
X-Gm-Message-State: AGi0PuZ6kEGfKJk/PTLymcBTTrggOTgpILGdbddIrqf0qMupzNW1BhJm
        t1y9gXnfpfZMR2Brt5D1/WzrvsM7eHc=
X-Google-Smtp-Source: APiQypKWVxTe+Ph/kO8cRDXhMu8/9u7uP6NoCX9nQn0sCCiaMfEPf6vI0h5KVn2HrndC6UnLtdAfwA==
X-Received: by 2002:a37:4981:: with SMTP id w123mr11308375qka.497.1586797715786;
        Mon, 13 Apr 2020 10:08:35 -0700 (PDT)
Received: from localhost ([199.96.181.106])
        by smtp.gmail.com with ESMTPSA id x7sm3570637qkx.36.2020.04.13.10.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 10:08:34 -0700 (PDT)
Date:   Mon, 13 Apr 2020 13:08:33 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        cgroups@vger.kernel.org, newella@fb.com, josef@toxicpanda.com,
        ming.lei@redhat.com, bvanassche@acm.org
Subject: Re: [PATCHSET v2 block/for-5.8] iocost: improve use_delay and
 latency target handling
Message-ID: <20200413170833.GD60335@mtj.duckdns.org>
References: <20200413162758.97252-1-tj@kernel.org>
 <dd55f890-740c-16b5-77bd-4c6fdb710b3d@gmail.com>
 <6f69d35c-c593-f140-c351-c7fd2c13069e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f69d35c-c593-f140-c351-c7fd2c13069e@gmail.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Apr 13, 2020 at 08:00:29PM +0300, Pavel Begunkov wrote:
> On 13/04/2020 19:56, Pavel Begunkov wrote:
> > On 13/04/2020 19:27, Tejun Heo wrote:
> >> Changes from v1[1]
> >>
> >> * Dropped 0002-block-add-request-io_data_len.patch and updated to use
> >>   rq->stats_sectors instead as suggested by Pavel Begunkov.
> > 
> > rq->stats_sectors is set only when there is QUEUE_FLAG_STATS, see
> > blk_mq_start_request(). I don't see blk-iocost requiring it. Did I miss something?
> 
> And there is no reason to not initialise it unconditionally.

The updated patch turns on accounting when iocost is enabled on a queue.

  @@ -2267,6 +2295,7 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
   	spin_lock_irq(&ioc->lock);
 
   	if (enable) {
  +		blk_stat_enable_accounting(ioc->rqos.q);
   		blk_queue_flag_set(QUEUE_FLAG_RQ_ALLOC_TIME, ioc->rqos.q);
   		ioc->enabled = true;
   	} else {

Thanks.

-- 
tejun

Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 589FD431204
	for <lists+cgroups@lfdr.de>; Mon, 18 Oct 2021 10:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbhJRITa (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 18 Oct 2021 04:19:30 -0400
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21403 "EHLO
        sender4-of-o54.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbhJRITa (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 18 Oct 2021 04:19:30 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1634544036; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=ARM3XR8ozbk5ZKj0o0HG2ck/7mjnAPp4awkkTw3VapiUpDnPJ9qBxfM0tRgqxaqk/JdjUC4lVy8jVAruMw9H99mGYUNd27FTYYu2Q8o7wzVFz7GH9ExR1ACawGXRRVeAJO8g6LRUAtwz8hcZmM4LnYMu8bFL1X5jSZ9KzPJo8DM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1634544036; h=Content-Type:Cc:Date:From:MIME-Version:Message-ID:Reply-To:Subject:To; 
        bh=h49ZUkYbpHvFgd4ygOJoSWfJB1R1I4UzMaRy7bssn/0=; 
        b=juUmx1ezfKgDa8C/3MBdDsGgAISJpdNYMNRQtFIwuTn1mU+m+WN/HYZPc2r4grhZ/eqkfNhL6xth1SZsFZmK4/FOSVO4Ct3HwxMaw+o/cXofRlvIZVEQqKxWDmZJViKXxFD/nGAqmCRZmLLOAyC39ZB220p7Hz6STsQdEPnuwz0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        spf=pass  smtp.mailfrom=www@aegistudio.net;
        dmarc=pass header.from=<www@aegistudio.net>
Received: from aegistudio (115.216.104.229 [115.216.104.229]) by mx.zohomail.com
        with SMTPS id 1634544032608898.571502480912; Mon, 18 Oct 2021 01:00:32 -0700 (PDT)
Date:   Mon, 18 Oct 2021 08:00:27 +0000
From:   Haoran Luo <www@aegistudio.net>
To:     zhangyoufu@gmail.com
Cc:     axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, tj@kernel.org
Subject: Re: [BUG] blk-throttle panic on 32bit machine after startup
Message-ID: <YW0pm5xcxgWnW98f@aegistudio>
Reply-To: CAEKhA2x1Qi3Ywaj9fzdsaChabqDSMe2m2441wReg_V=39_Cuhg@mail.gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ZohoMailClient: External
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

(Sorry for the garbled message due to my mistaken the configuration of mutt)

I'm the college of the reporter and I would like to provide more
information.

The code in 5.15-rc6 in "blk-throttle.c" around line 791 is written as
below:

	/*
	 * Previous slice has expired. We must have trimmed it after
	 * last
	 * bio dispatch. That means since start of last slice, we never
	 * used
	 * that bandwidth. Do try to make use of that bandwidth while
	 * giving
	 * credit.
	 */
	if (time_after_eq(start, tg->slice_start[rw]))
		tg->slice_start[rw] = start;

I think this piece of code presumes all jiffies values are greater than
0, which is the initial value assigned when kzalloc-ing throtl_grp. It
fails on 32-bit linux for the first 5 minutes after booting, since the
jiffies value then will be less than 0.

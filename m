Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67DF74311EF
	for <lists+cgroups@lfdr.de>; Mon, 18 Oct 2021 10:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbhJRIOb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 18 Oct 2021 04:14:31 -0400
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21405 "EHLO
        sender4-of-o54.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbhJRIOb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 18 Oct 2021 04:14:31 -0400
X-Greylist: delayed 905 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Oct 2021 04:14:31 EDT
ARC-Seal: i=1; a=rsa-sha256; t=1634543832; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=O4bUdhmhAsUoxuGtdP/u/rVDEgk3zpRhPwU3R0m6YQ6WvSm1IxPclr1t+hkyMEuvydHOO1UdTgHeqHfGeWhDNEkaj6PFEcCsPM1jktrZCfoSchZQPiHjKVEPf7Z01PVQsI/6uI0NSPHaCsh4JeWeha2Iu0syh0AG1q0pN4Fl8EY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1634543832; h=Content-Type:Cc:Date:From:MIME-Version:Message-ID:To; 
        bh=6i/ikiTl6VDyFWRFwnfMh0FhglL3FqTq7yzF2gG1Jro=; 
        b=eMuZ5NHHFTR06KBfXiPRWboGpxMaqegZzaRwvw7h5YC8voQK8ysfhfJtMfCklsMQfo35hMyNC3nrQlkBxOkMaHshZwqijSOOM9snuoEqbaI5Y+SBT3pgfa5ZiR7JLz/kRiyS+8WU81XUErczfYroGP9pBH4mDeQk8zR7ha/wSfA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        spf=pass  smtp.mailfrom=www@aegistudio.net;
        dmarc=pass header.from=<www@aegistudio.net>
Received: from aegistudio (115.216.104.229 [115.216.104.229]) by mx.zohomail.com
        with SMTPS id 1634543827489158.78767320003806; Mon, 18 Oct 2021 00:57:07 -0700 (PDT)
Date:   Mon, 18 Oct 2021 07:57:01 +0000
From:   Haoran Luo <www@aegistudio.net>
To:     zhangyoufu@gmail.com
Cc:     axboe@kernel.dk, cgroups@vger.kernel.org
Message-ID: <YW0ozaLztSuGilBh@aegistudio>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ZohoMailClient: External
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

linux-block@vger.kernel.org, tj@kernel.org
Bcc: 
Subject: Re: [BUG] blk-throttle panic on 32bit machine after startup
Reply-To:
CAEKhA2x1Qi3Ywaj9fzdsaChabqDSMe2m2441wReg_V=39_Cuhg@mail.gmail.com

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

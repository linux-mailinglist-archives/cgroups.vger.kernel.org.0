Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD5E431369
	for <lists+cgroups@lfdr.de>; Mon, 18 Oct 2021 11:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbhJRJ1o (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 18 Oct 2021 05:27:44 -0400
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21462 "EHLO
        sender4-of-o54.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbhJRJ1o (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 18 Oct 2021 05:27:44 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1634549128; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=P16/MXRb00Y1dFyKfnzWMlMgWGq4Y9+dSDHmHTDPjjEOLpTcnVXPNKCMtuhJOHHILM/TmStARK6cfJxGEmYYwLTVOrXHflJY5i6GEu7dp4v1JKhhkyrRyInGOemxc7DhyXBYijfJhDec3H27HBTsmO2B3pXt4ZKIi+V9OO0+x+s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1634549128; h=Content-Type:Cc:Date:From:MIME-Version:Message-ID:Reply-To:Subject:To; 
        bh=otTsBZa70MX6QghBvUt6YAtmdC1HkIcx0ZEGFPr2XNI=; 
        b=ZWaC0RF9YkiviKUgt8qxYfh65TmyKJjmgE3nBFJ+f53DoqoQbKIXXgu4fiHVFijwJRaC0KsCKy730e9WLX4vlp2wClPIq3U6Zsl0UFToYNupmySNxf324cUbp5SXw6B2r8SnE8oFLx6123etKNJ5Sh/T4KJbXmQmj8slDhC3gkY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        spf=pass  smtp.mailfrom=www@aegistudio.net;
        dmarc=pass header.from=<www@aegistudio.net>
Received: from aegistudio (115.216.104.229 [115.216.104.229]) by mx.zohomail.com
        with SMTPS id 1634549123491906.7996972076187; Mon, 18 Oct 2021 02:25:23 -0700 (PDT)
Date:   Mon, 18 Oct 2021 09:25:11 +0000
From:   Haoran Luo <www@aegistudio.net>
To:     Haoran Luo <www@aegistudio.net>
Cc:     axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, tj@kernel.org, zhangyoufu@gmail.com
Subject: Re: [BUG] blk-throttle panic on 32bit machine after startup
Message-ID: <YW09dxyhhsMwaO7T@aegistudio>
Reply-To: YW0pm5xcxgWnW98f@aegistudio
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ZohoMailClient: External
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Pardon me for elaborating some of my opinions.

> I think this piece of code presumes all jiffies values are greater than
> 0, which is the initial value assigned when kzalloc-ing throtl_grp. It
> fails on 32-bit linux for the first 5 minutes after booting, since the
> jiffies value then will be less than 0.

Expressing the jiffies value as greater or less than 0 is a mistake of vagueness. I actually means that comparison in macro "time_after_eq", which written as below in "5.16-rc2" in "include/linux/jiffies.h" at around line 110.

	#define time_after_eq(a,b)	\
		(typecheck(unsigned long, a) && \
		 typecheck(unsigned long, b) && \
		 ((long)((a) - (b)) >= 0))

The "INITIAL_JIFFIES" which is defined as "((unsigned long)(unsigned int)-300*HZ)", converts to "((long)-300*HZ)" and is smaller than "((long)0)". And similarily "timer_after_eq(x, 0)" being evaluated to false holds for x ranged from `INITIAL_JIFFIES <= x <= MAX_LONG` on 32-bit linux.

The same thing will not happen for 64-bit linux, since "((unsigned long)(unsigned int)-300*HZ)" is evaluated to a value greater than zero in the macro above.

I actually cannot figure out a fix for this problem on 32-bit, if it presumes the jiffies value in "tg->slice_start[rw]" to be either "0" or jiffies "x" holding property of "time_after_eq(x, 0)".

Return-Path: <cgroups+bounces-1723-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CDE85D2CD
	for <lists+cgroups@lfdr.de>; Wed, 21 Feb 2024 09:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F2ACB22B9D
	for <lists+cgroups@lfdr.de>; Wed, 21 Feb 2024 08:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E279C3C6BC;
	Wed, 21 Feb 2024 08:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="MuyQoYny";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="CODpCW6j"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07CA3CF40;
	Wed, 21 Feb 2024 08:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708505289; cv=none; b=OCdibsMdemeKGZR4NK4kfZhbrIabVfb4EES8ozpECzTxE11brA+avSJ8v0HgIRJPJDb2wbN7aF10RG9tI4t4ZXWN7APmItOXqGoxqr15PrKOM8PsTNilSXEbzK2xeBJ0iWpZA29c5Q+XrCYajW5VQgoW4yZq3/hvXwxgFRQ/clc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708505289; c=relaxed/simple;
	bh=YcCWbDSlo7QLQYDoEPSoFM5eNkpT500njQPZDVtQJfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nonYF+hkn2mXqAFPs3dbmNnqSs/ihBuMXTh3f2dTASCYDvwQ1HsTIKhK4yF3rC0yncNk6Gz6coHoUl2d3hUt5xYfK1AfIG35kRWQQwPXohtArLDtQ5hDQStDiMUlHp3pT+rSsElNoEQn2Ak0SOd8IVvcrkuWKU/ZvFW1P1IXrfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=MuyQoYny; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=CODpCW6j; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E9F361FB49;
	Wed, 21 Feb 2024 08:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708505286; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w5816RGw/j39WoE2zZEO5USdo6xNlHTN6koZRBrJLA4=;
	b=MuyQoYnyj/envEa0nOPFxjsn+4YSQNLlyILD/KTntO0aSdNlDQP6FmZRlV6oVufRBC1JYZ
	4Cj+0MIhEYDw84L0e3Uo979m1rehsouGxST6gJlvxa1Z5+Zad+bA4sw6YVoyuLae2TFPFr
	udiUJ2/dBQSqCbNuhhDpWpZn9uoKRJY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708505285; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w5816RGw/j39WoE2zZEO5USdo6xNlHTN6koZRBrJLA4=;
	b=CODpCW6j5L1rhcIplo+vpU9LKXAfzhjSDF8F/BcR3U2FU0xS6zz+MGmCoZo1h2fRXyGyw3
	plc8Eub//Xns6msMCt/0SsT7Hc4802BwVFcquNOH2RLZnszntMPb4G+02ANqfHGnxMcIqo
	Ppmk9SUDRD1xJqajqaDQEy2wkr9cOZw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CB050139D0;
	Wed, 21 Feb 2024 08:48:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id i6bxL8W41WXwKwAAD6G6ig
	(envelope-from <mhocko@suse.com>); Wed, 21 Feb 2024 08:48:05 +0000
Date: Wed, 21 Feb 2024 09:48:05 +0100
From: Michal Hocko <mhocko@suse.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "GONG, Ruiqi" <gongruiqi1@huawei.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, Wang Weiyang <wangweiyang2@huawei.com>,
	Xiu Jianfeng <xiujianfeng@huawei.com>
Subject: Re: [PATCH stable] memcg: add refcnt for pcpu stock to avoid UAF
 problem in drain_all_stock()
Message-ID: <ZdW4xR-Ke227pxjG@tiehlicka>
References: <20240221081801.69764-1-gongruiqi1@huawei.com>
 <2024022119-bogged-action-c877@gregkh>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024022119-bogged-action-c877@gregkh>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-0.58 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.98)[86.99%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -0.58

On Wed 21-02-24 09:40:29, Greg KH wrote:
> On Wed, Feb 21, 2024 at 04:18:01PM +0800, GONG, Ruiqi wrote:
> > commit 1a3e1f40962c445b997151a542314f3c6097f8c3 upstream.
> > 
> > There was a kernel panic happened on an in-house environment running
> > 3.10, and the same problem was reproduced on 4.19:
> 
> Now queued up, thanks!

Give it some more time Greg, http://lkml.kernel.org/r/ZdW2gMajIw_cUN2-@tiehlicka

-- 
Michal Hocko
SUSE Labs


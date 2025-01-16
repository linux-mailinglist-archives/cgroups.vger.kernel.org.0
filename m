Return-Path: <cgroups+bounces-6187-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE81A1378B
	for <lists+cgroups@lfdr.de>; Thu, 16 Jan 2025 11:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77A6F188AC18
	for <lists+cgroups@lfdr.de>; Thu, 16 Jan 2025 10:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4141DDA32;
	Thu, 16 Jan 2025 10:12:47 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5431DC046
	for <cgroups@vger.kernel.org>; Thu, 16 Jan 2025 10:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737022367; cv=none; b=MswuvqW/PMkGcXj0fzR/SjAxL7zyPX+lLIy7ejGr5mNJD47Py9DmbdhwRvFahwL+F+R35HG2MsEmaQhym9KK+jxSojVINrFozS1tgCHddaxfX8NuzNdseRd69xnDYivYZOYZbJUqpiAnwW7xag6tNv3xupZZkgYm/xNY8GK0B4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737022367; c=relaxed/simple;
	bh=nQElmkQigT7M0NGqIF5Q7VZ3Cm/8AbbBy57AH7VPHAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OTtv7Y+gD1VwWq8nk8vSlQWXdhQbdD+fzrr78DeTn7Brqh9xGQ0ZNbuEQzYLYhWOQ6PntH4clkvIZZl3f+i4S5isw5p5wYQRs/lgCuoj1dhsXfSBrO26mXiXRtQremewvx2UVJmBNWdTMMC/lJ6D/NZTgbeGlD/aOaAt/3SPG60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B9FF7211C4;
	Thu, 16 Jan 2025 10:12:43 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 702F313A57;
	Thu, 16 Jan 2025 10:12:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iv1CGZvbiGcuGAAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Thu, 16 Jan 2025 10:12:43 +0000
Date: Thu, 16 Jan 2025 11:12:42 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Michal Hocko <mhocko@suse.com>
Cc: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>,
	Li Wang <liwang@redhat.com>, Cyril Hrubis <chrubis@suse.cz>,
	ltp@lists.linux.it, cgroups@vger.kernel.org
Subject: Re: [LTP] Issue faced in memcg_stat_rss while running mainline
 kernels between 6.7 and 6.8
Message-ID: <20250116101242.GA679477@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <e66fcf77-cf9d-4d14-9e42-1fc4564483bc@oracle.com>
 <PH7PR10MB650583A6483E7A87B43630BDAC302@PH7PR10MB6505.namprd10.prod.outlook.com>
 <20250115125241.GD648257@pevik>
 <20250115225920.GA669149@pevik>
 <Z4i6-WZ73FgOjvtq@tiehlicka>
 <6ee7b877-19cc-4eda-9ea7-abf3af0a1b57@oracle.com>
 <Z4jL_GzJ98S_VYa3@tiehlicka>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4jL_GzJ98S_VYa3@tiehlicka>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO
X-Rspamd-Queue-Id: B9FF7211C4
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

Hi Michal, all,

> On Thu 16-01-25 13:37:14, Harshvardhan Jha wrote:
> > Hello Michal
> > On 16/01/25 1:23 PM, Michal Hocko wrote:
> > > Hi,

> > > On Wed 15-01-25 23:59:20, Petr Vorel wrote:
> > >> Hi Harshvardhan,

> > >> [ Cc cgroups@vger.kernel.org: FYI problem in recent kernel using cgroup v1 ]
> > > It is hard to decypher the output and nail down actual failure. Could
> > > somebody do a TL;DR summary of the failure, since when it happens, is it
> > > really v1 specific?

> > The test ltp_memcg_stat_rss is indeed cgroup v1 specific.

> What does this test case aims to test?

I'm not an expert on cgroup tests, maybe Li or Cyril will comment better.

memcg_stat_rss.sh [1] claims "Test the management and counting of memory",
test_mem_stat() [2] checks memory.stat doing some memory allocation.
Each test runs memcg_process.c [3], which does various mmap(),
followed by checks.

These tests are quite old, not sure how relevant they are. We have newer tests
written completely in C, which are more reliable.

Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/controllers/memcg/functional/memcg_stat_rss.sh#L17C3-L17C45
[2] https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/controllers/memcg/functional/memcg_lib.sh#L249
[3] https://github.com/linux-test-project/ltp/tree/master/testcases/kernel/controllers/memcg/functional/memcg_process.c



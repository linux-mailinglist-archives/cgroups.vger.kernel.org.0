Return-Path: <cgroups+bounces-8462-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A002AD1EF7
	for <lists+cgroups@lfdr.de>; Mon,  9 Jun 2025 15:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 003D5188D558
	for <lists+cgroups@lfdr.de>; Mon,  9 Jun 2025 13:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4816254AF0;
	Mon,  9 Jun 2025 13:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OL+gSCOH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Jh7CpW7I";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="x8fgWWPZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZSfhp70B"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12CF18027
	for <cgroups@vger.kernel.org>; Mon,  9 Jun 2025 13:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749476019; cv=none; b=SQzv251G75hV/ZQZCJvnUjx2NJAPC0TVI7CLx3pwPd9kVR+kn/skODxn2r/yHWGGlQKOVI9D8H5YmfrdcScKRtJvY++KAWbOlCNyvILr3Yxn6h0ZFjTyCAw2x5dKRYjB1AHFtaKsWD46X2espbvulL7gV7MZeLKN94dY73VZ7uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749476019; c=relaxed/simple;
	bh=uy/v/SnUTsDKYyCwhC8AFTTpTshbTPCnrIWHXQSTiTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hdYPdsFW1Mf9OPH3iHrgstKjNvjtkTZ/QXNroa8KOPWImtlQ0oQhI4Z5LZohkWIKE2Z3vAKiSALIGc5r4rb0ugmI+zve38L894mGRtgFFhRgxxNAsL0uynKoj1T7AStGuD5t/JKWGQFcKCcjlvFvTUJyz4mDANnWRpNVLTVXAXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OL+gSCOH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Jh7CpW7I; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=x8fgWWPZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZSfhp70B; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DA7221F38F;
	Mon,  9 Jun 2025 13:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749476015;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3oT43xovplUHySslryULLRttrqsdZDzMb2KNCso4qHw=;
	b=OL+gSCOHDEO40LnbXQcApFlxl/Qo2JV3wy8Z+HfE6nOkiMNvQQLYkpEmjpzf+BCjZf4Dh5
	XgLibyAGgUjE2opsu65gcJWGisFbTkupVLKNyfqTq1F7Ih0lztn21UEEz2NrCavAuD7x3O
	qAUifPKOgpNIFMKy3GAQnBWTWO1Pbys=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749476015;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3oT43xovplUHySslryULLRttrqsdZDzMb2KNCso4qHw=;
	b=Jh7CpW7Iclk0uR8ExgkYk36ZWwMlxvm15e3SotoEc30YcBKOFXws6HrZjFTYecYX27uFMq
	pL+DRSbHluOfSfBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=x8fgWWPZ;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ZSfhp70B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749476014;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3oT43xovplUHySslryULLRttrqsdZDzMb2KNCso4qHw=;
	b=x8fgWWPZrIkBwz2TxebT4FA1J1h+MauIAUjGA5cqRV1EYVoOJ3FZx0ovkKmlsLC7ho1Mtd
	S11CtNAqQEgpByustrfxAl2Px6CBWV+aLiLZ+h7LBN0XrW8zDSYKglHEmsJD4hhUIyA40o
	ws8Lc6bo/bzonHZXiX/PtbZ8LmeXVjg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749476014;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3oT43xovplUHySslryULLRttrqsdZDzMb2KNCso4qHw=;
	b=ZSfhp70BaQ16dVatKl/kkzrAoQN+by/yRfwxFY1PAtoUCrFgDVcA5aBPdTmK+iFM9cGOT1
	hxTuvToVs03Ei0AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7C727137FE;
	Mon,  9 Jun 2025 13:33:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id D0NZG67iRmjNXwAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Mon, 09 Jun 2025 13:33:34 +0000
Date: Mon, 9 Jun 2025 15:33:32 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Michal =?iso-8859-2?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: Wei Gao <wegao@suse.com>, ltp@lists.linux.it,
	Li Wang <liwang@redhat.com>, cgroups@vger.kernel.org
Subject: Re: [LTP] [PATCH v1] sched_rr_get_interval01.c: Put test process
 into absolute root cgroup (0::/)
Message-ID: <20250609133332.GA1501907@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20250605142943.229010-1-wegao@suse.com>
 <20250605094019.GA1206250@pevik>
 <orzx7vfokvwuceowwjctea4yvujn75djunyhsqvdfr5bw7kqe7@rkn5tlnzwllu>
 <aESIDuS42cY_sLBe@MiWiFi-CR6608-srv>
 <rugkmu3bcsrqgehibgy3dn7nsisuv6lip7b5cmo3bewq4zjcdn@zuo6hg25pqyz>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <rugkmu3bcsrqgehibgy3dn7nsisuv6lip7b5cmo3bewq4zjcdn@zuo6hg25pqyz>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: DA7221F38F
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.71 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	URIBL_BLOCKED(0.00)[suse.cz:dkim,suse.cz:replyto,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,suse.com:email];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]
X-Spam-Score: -3.71
X-Spam-Level: 

Hi all,

> On Sat, Jun 07, 2025 at 02:42:22PM -0400, Wei Gao <wegao@suse.com> wrote:
> > @Michal Koutný  So we should skip test cgroupv2 with CONFIG_RT_GROUP_SCHED=yes, correct? 

> Ideally, no one should run v2 with CONFIG_RT_GROUP_SCHED=y, so this
> would never fail :-p

@Michal thanks for a clarification. It's default n and
Documentation/scheduler/sched-rt-group.rst which mentions CONFIG_RT_GROUP_SCHED
also mentions Documentation/admin-guide/cgroup-v1/cgroups.rst, that should be a
good hint for people changing the defaults :).

Also, there are 3 old mips and sh boards which set CONFIG_RT_GROUP_SCHED=y.
Probably nobody cares much nowadays, but maybe it should be deleted.

> > Like following change?

> But if there are such poor souls, that skip should make the test not
> obstruct the rest of LTP.

@Andrea, you claimed it's merged, but maybe you reply to a wrong thread
because it's not merged.
https://lore.kernel.org/ltp/b15fa0cb-e893-4642-9aa0-05f732b75131@suse.com/

I agree with Cyril to have a custom function in lib/tst_cgroup.c, which would be
called by affected tests.

Kind regards,
Petr

> Thanks,
> Michal




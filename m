Return-Path: <cgroups+bounces-4694-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 626A596BC53
	for <lists+cgroups@lfdr.de>; Wed,  4 Sep 2024 14:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A143281775
	for <lists+cgroups@lfdr.de>; Wed,  4 Sep 2024 12:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A49A1D9334;
	Wed,  4 Sep 2024 12:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZECzvWA9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FyNHAqsi";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZECzvWA9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FyNHAqsi"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3379D1E864;
	Wed,  4 Sep 2024 12:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725453013; cv=none; b=DfGgzCMXQuiLw5znzzAlsU7JrEVFY8cSsgqXWVIu/6xBLznNM8Ah5QCYCHKvNGz/5LFG/kUu/1/aWbVZU/pPTlN4ariSJlYwrPGtv6Op5LZeAC4I+e6PASW7a6QyXoXZdSiJPvGSzu0Z5jQ4ZD2kwxtdrIeeOI1n1KfPjK5O1Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725453013; c=relaxed/simple;
	bh=3oxY0cANxzzP6HsLlcU867lK3DzvrOlkPdYQD1lgiEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dIXL0BIptHovaCs4PmL/4+sx9ZyPv0X1pb2UAdUId7vT4ULVxsn1IMsFYfl6pdKla9P/u7xv2utkG+PD1EQNP4/YCpL40wd3vZdQt3FyDofMtKRik32qq0eEwc2MKHIatJYhYVNdxuwkj6K0YohRG8fhcYD8I8EfWqkav+U45FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZECzvWA9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FyNHAqsi; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZECzvWA9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FyNHAqsi; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3F1391F38E;
	Wed,  4 Sep 2024 12:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725453009; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5qMnG3dgUtINYEoiYxFbxfr0kZzl3u7GxUdlt29/LtU=;
	b=ZECzvWA9xEDhyLgA+shXS7VQ78brc86X1yDM+t16ogVFB8pmRXTEDhe2/Sw//eJmy3pmuG
	OfieF/TZB4/WvkFloARVKyhb49FMbg1yLUmrfj7Eb733qjifBAb9pVp1irOdy3O4vJQ5xR
	AlMq+5TQ5C3/1+dX8FZFxVN3DFoIaS0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725453009;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5qMnG3dgUtINYEoiYxFbxfr0kZzl3u7GxUdlt29/LtU=;
	b=FyNHAqsi3/RMtB+IO2fu+gtkwMcLIk8HC4yPLF34L2JRT8Lv+/gzrK2lYtDMUleTje57vJ
	85xQT0hlNCYecjBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ZECzvWA9;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=FyNHAqsi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725453009; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5qMnG3dgUtINYEoiYxFbxfr0kZzl3u7GxUdlt29/LtU=;
	b=ZECzvWA9xEDhyLgA+shXS7VQ78brc86X1yDM+t16ogVFB8pmRXTEDhe2/Sw//eJmy3pmuG
	OfieF/TZB4/WvkFloARVKyhb49FMbg1yLUmrfj7Eb733qjifBAb9pVp1irOdy3O4vJQ5xR
	AlMq+5TQ5C3/1+dX8FZFxVN3DFoIaS0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725453009;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5qMnG3dgUtINYEoiYxFbxfr0kZzl3u7GxUdlt29/LtU=;
	b=FyNHAqsi3/RMtB+IO2fu+gtkwMcLIk8HC4yPLF34L2JRT8Lv+/gzrK2lYtDMUleTje57vJ
	85xQT0hlNCYecjBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 27E40139D2;
	Wed,  4 Sep 2024 12:30:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WDi0CdFS2GZWUAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 04 Sep 2024 12:30:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C5C37A0968; Wed,  4 Sep 2024 14:29:53 +0200 (CEST)
Date: Wed, 4 Sep 2024 14:29:53 +0200
From: Jan Kara <jack@suse.cz>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Jens Axboe <axboe@kernel.dk>, jack@suse.cz, tj@kernel.org,
	josef@toxicpanda.com, paolo.valente@unimore.it,
	mauro.andreolini@unimore.it, avanzini.arianna@gmail.com,
	cgroups@vger.kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH for-6.12 0/4] block, bfq: fix corner cases related to
 bfqq merging
Message-ID: <20240904122953.fkwyfsfwhrwwmnbs@quack3>
References: <20240902130329.3787024-1-yukuai1@huaweicloud.com>
 <2ee05037-fb4f-4697-958b-46f0ae7d9cdd@kernel.dk>
 <c2a6d239-aa96-f767-9767-9e9ea929b014@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c2a6d239-aa96-f767-9767-9e9ea929b014@huaweicloud.com>
X-Rspamd-Queue-Id: 3F1391F38E
X-Spam-Level: 
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[kernel.dk,suse.cz,kernel.org,toxicpanda.com,unimore.it,gmail.com,vger.kernel.org,huawei.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.com:email,huawei.com:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.51
X-Spam-Flag: NO

On Wed 04-09-24 09:32:26, Yu Kuai wrote:
> 在 2024/09/03 23:51, Jens Axboe 写道:
> > On 9/2/24 7:03 AM, Yu Kuai wrote:
> > > From: Yu Kuai <yukuai3@huawei.com>
> > > 
> > > Our syzkaller report a UAF problem(details in patch 1), however it can't
> > > be reporduced. And this set are some corner cases fix that might be
> > > related, and they are found by code review.
> > > 
> > > Yu Kuai (4):
> > >    block, bfq: fix possible UAF for bfqq->bic with merge chain
> > >    block, bfq: choose the last bfqq from merge chain in
> > >      bfq_setup_cooperator()
> > >    block, bfq: don't break merge chain in bfq_split_bfqq()
> > >    block, bfq: use bfq_reassign_last_bfqq() in bfq_bfqq_move()
> > > 
> > >   block/bfq-cgroup.c  |  7 +------
> > >   block/bfq-iosched.c | 17 +++++++++++------
> > >   block/bfq-iosched.h |  2 ++
> > >   3 files changed, 14 insertions(+), 12 deletions(-)
> > 
> > BFQ is effectively unmaintained, and has been for quite a while at
> > this point. I'll apply these, thanks for looking into it, but I think we
> > should move BFQ to an unmaintained state at this point.
> 
> Sorry to hear that, we would be willing to take on the responsibility of
> maintaining this code, please let me know if there are any specific
> guidelines or processes we should follow. We do have customers are using
> bfq in downstream kernels, and we are still running lots of test for
> bfq.

That would be awesome. I don't think there's much of a process to follow
given there's not much happening in BFQ. You can add yourself to
MAINTAINERS file under "BFQ I/O SCHEDULER" entry and then do your best to
keep BFQ alive by fixing bugs and responding to reports :) I'm not sure if
Jens would prefer you'd create your git tree from which he will pull or
whether merging patches is fine - he has to decide.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


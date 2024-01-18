Return-Path: <cgroups+bounces-1173-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F6483162D
	for <lists+cgroups@lfdr.de>; Thu, 18 Jan 2024 10:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54009282101
	for <lists+cgroups@lfdr.de>; Thu, 18 Jan 2024 09:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFA31F934;
	Thu, 18 Jan 2024 09:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qBR3Q25J";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="m6WwSFX0"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC591B978;
	Thu, 18 Jan 2024 09:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705571378; cv=none; b=lyN6xCy5LvNSUCR6jwCZDdCwnYBg1SSX1Lgw1X83pnUdFpSEsGM38oyoZED0BiLxfhTRr0MM746h8jPSwfNdbJHO1ha3fuXZEY7wuJ+8vdtqWpMwSyhYRSDo/RKdBYxnAO2+io+RcDlQFiH4OxR2m9ATX9n3zhCHeLtVOXTtK6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705571378; c=relaxed/simple;
	bh=Xx1w2j0Ut6qee5gadoLoqIjcIiSaRiZlSco/pUHyEh8=;
	h=Received:DKIM-Signature:DKIM-Signature:Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Spam-Level:X-Rspamd-Server:
	 X-Spamd-Result:X-Spam-Score:X-Rspamd-Queue-Id:X-Spam-Flag; b=rdJ1SKG3gM/YHYsMx7LrB4g0OnvDtfdiEuEvlzhpwZKfxG6UolpGjgIYE9vGRfXqDVv/vXW2qSLUF4cF2tVfwvlKQix3tARV04TdcsuqR2luE61FxZL8hg+RdiMfXxpE0B1bPslxebVX5Ce92Am9YMPyqer+Cqn8JAZpOqH3U/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qBR3Q25J; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=m6WwSFX0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E50011F76E;
	Thu, 18 Jan 2024 09:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705571374; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jz/0ds8afeq3DpOVl8DS5UXtCEYQMmU6QgXHoRDaeGc=;
	b=qBR3Q25J9klgtYkNFKQe3s8GVc+znkGesqzm2ClVjNWKA0Q+PE/2MbzpqOCzajEhytLd9n
	zkGg/1tyTknXB5ZWForDujNYOerJYiRhpp48gLZRvizUGnnHGJqUSH7yPnGLznIMts6hTa
	pJqkD7XFuBoPHh+J7PWW174bl8Vcig0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705571373; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jz/0ds8afeq3DpOVl8DS5UXtCEYQMmU6QgXHoRDaeGc=;
	b=m6WwSFX00eeqMGnOpFRCh/+cexaLtJCSsD+wOsgNkvI54cpVharnqpE49XNuMWyPXEoJ/V
	mPkxWQlraFajlLD9SOBtdIjHC/gdqOkluZzd3Z1iINullDmg72/1BYPgvuQOEcpL9qKxAN
	h8zReVQees4G2Z7OOfT015tfml+GJVU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C654713874;
	Thu, 18 Jan 2024 09:49:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NX5uLS30qGVSPwAAD6G6ig
	(envelope-from <mhocko@suse.com>); Thu, 18 Jan 2024 09:49:33 +0000
Date: Thu, 18 Jan 2024 10:49:33 +0100
From: Michal Hocko <mhocko@suse.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Shakeel Butt <shakeelb@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
	Vasily Averin <vasily.averin@linux.dev>,
	Michal Koutny <mkoutny@suse.com>, Waiman Long <longman@redhat.com>,
	Muchun Song <muchun.song@linux.dev>, Jiri Kosina <jikos@kernel.org>,
	cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH RFC 1/4] fs/locks: Fix file lock cache accounting, again
Message-ID: <Zaj0LYIJRL9TNj2R@tiehlicka>
References: <cover.1705507931.git.jpoimboe@kernel.org>
 <ac84a832feba5418e1b58d1c7f3fe6cc7bc1de58.1705507931.git.jpoimboe@kernel.org>
 <6667b799702e1815bd4e4f7744eddbc0bd042bb7.camel@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6667b799702e1815bd4e4f7744eddbc0bd042bb7.camel@kernel.org>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=m6WwSFX0
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.70 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[17];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.69)[83.24%]
X-Spam-Score: -1.70
X-Rspamd-Queue-Id: E50011F76E
X-Spam-Flag: NO

On Wed 17-01-24 14:00:55, Jeff Layton wrote:
> I'm really not a fan of tunables or different kconfig options,
> especially for something niche like this.

I completely agree with that. We do have plethora of kernel objects
which are accounted and we really do not want to have a kernel cmd line
option for many/each of them. Kernel memory accounting can be disabled
through kernel cmd line already. 
-- 
Michal Hocko
SUSE Labs


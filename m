Return-Path: <cgroups+bounces-2233-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED23890921
	for <lists+cgroups@lfdr.de>; Thu, 28 Mar 2024 20:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3312F1F29C4C
	for <lists+cgroups@lfdr.de>; Thu, 28 Mar 2024 19:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A3E137C26;
	Thu, 28 Mar 2024 19:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Cngsym2B";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TSDDrWfH"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512103BBCA;
	Thu, 28 Mar 2024 19:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711653815; cv=none; b=nJOr4ES71BMUAv8ejXqqqclVbaxjkSFVdyCaW1S5BpNN3j7Wduw05KyxJKHZeIwe4aVYmqfsL6XWXYj2AYucQmEFiS8ovHw6Sxvls5yjlNqi2FNbG6fHDHBN5kJL/8SwcERoTp9/umLs3Me+wXN7QA/Qns5Xe9u8ljTvzkHy9Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711653815; c=relaxed/simple;
	bh=wA/3ZMzsqhnPRDvcXtmhlRKA0r/1h+Jjze3JHfLTZzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DpJ/B3L4x5UOcYPZsSL1g2wOgCWpbs5RJHmGk2jx5X/1tQzfJ70xa9EfWZvPsWhP8WuREfob5VhvaDw15BNnz2G+9q3LTDjHDgH4n+td8j1kRCQnvRAA21AuNaE/UdNsq6dmwj/Dnr4lcT6k2xGnbC/Sygz8/+PNAm55yCXLzlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Cngsym2B; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TSDDrWfH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 688DA34336;
	Thu, 28 Mar 2024 19:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711653811;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ji3/UHuciPHNkExk7xa/gFONeP3sfxTR6+pZplh8sHw=;
	b=Cngsym2Bx1bWQZwsIC0zsKw0NzvpGxOk3akKbL4obhj7d1jb/iUdwFZLt1Qmv0adOFlG7s
	6RgLs7a8JOJDYVl2MEONXeeOkycod4dhhy5ZTk5vGNPi4W+RQIR/VSHMzxPThbcfRd+OMa
	lF7uFr5exuV7EWHqlpBjgURJ17wMPoE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711653811;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ji3/UHuciPHNkExk7xa/gFONeP3sfxTR6+pZplh8sHw=;
	b=TSDDrWfHiZ0MN2QLCLn9mZDB70GugkpLsGz/KGcuI46XhybN7OsWUj4DInvPdyCE0bbMvA
	L5XYOUgivHqdy/Ag==
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 4B8AD13A94;
	Thu, 28 Mar 2024 19:23:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id QUpLErPDBWYPLwAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Thu, 28 Mar 2024 19:23:31 +0000
Date: Thu, 28 Mar 2024 20:16:12 +0100
From: David Sterba <dsterba@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Matthew Sakai <msakai@redhat.com>, Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>, dm-devel@lists.linux.dev,
	cgroups@vger.kernel.org, linux-block@vger.kernel.org,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 4/4] btrfs use bio_list_merge_init
Message-ID: <20240328191612.GZ14596@suse.cz>
Reply-To: dsterba@suse.cz
References: <20240328084147.2954434-1-hch@lst.de>
 <20240328084147.2954434-5-hch@lst.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328084147.2954434-5-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-0.05 / 50.00];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	BAYES_HAM(-0.05)[59.90%];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.com:email]
X-Spam-Score: -0.05
X-Spam-Level: 
X-Spam-Flag: NO

On Thu, Mar 28, 2024 at 09:41:47AM +0100, Christoph Hellwig wrote:
> Use bio_list_merge_init instead of open coding bio_list_merge and
> bio_list_init.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: David Sterba <dsterba@suse.com>


Return-Path: <cgroups+bounces-1367-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3519984A882
	for <lists+cgroups@lfdr.de>; Mon,  5 Feb 2024 23:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C81B71F2CBB7
	for <lists+cgroups@lfdr.de>; Mon,  5 Feb 2024 22:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2AC1AB812;
	Mon,  5 Feb 2024 21:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="k2QTPAlp";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="k2QTPAlp"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7451AB806;
	Mon,  5 Feb 2024 21:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707167799; cv=none; b=l55TFodvNvHpU+AIfFiBJdfyuY3NRr4x1sNPYz9cZdhHex0csTlMJQLqSs9eZIqE9tcRuY/+ahDGpnXKWNyQxxp0QGBZeyh+2J4EKrM0xHA/bl8jQFZCFT5ypfc6oUPXtl/vr0NkR689iDh6hFWPwr4hWosLUrAHfhaDiPm/tvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707167799; c=relaxed/simple;
	bh=w+LuAn4eMxEN1OrwnjXfkUZofNi+HXJroO9FLryNtL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D4v8WBqwuh/JcQzY9v/cCXx/sR9ShlmsxKgb9891QHFrk//HQMjc/kAkCucbYUow/5SIJt4SsEVzGneuzJp+yahnbrYEQ74KJFIIAJ3d0xh36IKnLdYs6LcmscWFxAoT1ELi9kMEk47vG1IOKYs2rCbGbJdPjWahcKmq5ao1BIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=k2QTPAlp; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=k2QTPAlp; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 52B1021FB3;
	Mon,  5 Feb 2024 21:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707167795; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UqjQ8uzPWkoXvaP3jSmRX0mX+6vg7iSnhNElmOf67RA=;
	b=k2QTPAlpUZx9xWdcIwXtXXDq0RS18tpEXYVMAwgeXgBnBYJefWMYQ93JLDFkCalSq3ycUy
	VZAEpeop+Dxd1H2y4UYD/k2bR0lxrH87nVnAGgfJdz4CSRW/671XL7U+K2ActeCA0IKwI6
	nBokQeUPwfSSneyy/npR/ngpYbv+j+0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707167795; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UqjQ8uzPWkoXvaP3jSmRX0mX+6vg7iSnhNElmOf67RA=;
	b=k2QTPAlpUZx9xWdcIwXtXXDq0RS18tpEXYVMAwgeXgBnBYJefWMYQ93JLDFkCalSq3ycUy
	VZAEpeop+Dxd1H2y4UYD/k2bR0lxrH87nVnAGgfJdz4CSRW/671XL7U+K2ActeCA0IKwI6
	nBokQeUPwfSSneyy/npR/ngpYbv+j+0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F00A132DD;
	Mon,  5 Feb 2024 21:16:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tIwCCTNQwWWHUwAAD6G6ig
	(envelope-from <mhocko@suse.com>); Mon, 05 Feb 2024 21:16:35 +0000
Date: Mon, 5 Feb 2024 22:16:34 +0100
From: Michal Hocko <mhocko@suse.com>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Efly Young <yangyifei03@kuaishou.com>, android-mm@google.com,
	yuzhao@google.com, mkoutny@suse.com,
	Yosry Ahmed <yosryahmed@google.com>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm: memcg: Use larger batches for proactive reclaim
Message-ID: <ZcFQMru5_oATGbuP@tiehlicka>
References: <20240202233855.1236422-1-tjmercier@google.com>
 <ZcC7Kgew3GDFNIux@tiehlicka>
 <CABdmKX3HbSxX6zLF4z3f+=Ybiq1bA71jckkeHv5QJxAjSexgaA@mail.gmail.com>
 <ZcE5n9cTdTGJChmq@tiehlicka>
 <CABdmKX0Du2F+bko=hjLBqdQO-bJSFcG3y1Bbuu2v6J8aVB39sw@mail.gmail.com>
 <ZcFG2JoXI7i8XzQY@tiehlicka>
 <CABdmKX0t1LXj80Awe20TrmY5gQB6v2E4bGfW8WXr2i84o+k6ow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABdmKX0t1LXj80Awe20TrmY5gQB6v2E4bGfW8WXr2i84o+k6ow@mail.gmail.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [0.28 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.12)[66.62%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.28

On Mon 05-02-24 12:47:47, T.J. Mercier wrote:
> On Mon, Feb 5, 2024 at 12:36 PM Michal Hocko <mhocko@suse.com> wrote:
[...]
> > This of something like
> > timeout $TIMEOUT echo $TARGET > $MEMCG_PATH/memory.reclaim
> > where timeout acts as a stop gap if the reclaim cannot finish in
> > TIMEOUT.
> 
> Yeah I get the desired behavior, but using sc->nr_reclaimed to achieve
> it is what's bothering me.

I am not really happy about this subtlety. If we have a better way then
let's do it. Better in its own patch, though.

> It's already wired up that way though, so if you want to make this
> change now then I can try to test for the difference using really
> large reclaim targets.

Yes, please. If you want it a separate patch then no objection from me
of course. If you do no like the nr_to_reclaim bailout then maybe we can
go with a simple break out flag in scan_control.

Thanks!
-- 
Michal Hocko
SUSE Labs


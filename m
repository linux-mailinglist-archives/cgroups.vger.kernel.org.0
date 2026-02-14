Return-Path: <cgroups+bounces-13957-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPAiFIoOkGkPVwEAu9opvQ
	(envelope-from <cgroups+bounces-13957-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 14 Feb 2026 06:56:26 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A57213B2CC
	for <lists+cgroups@lfdr.de>; Sat, 14 Feb 2026 06:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC66F302BE29
	for <lists+cgroups@lfdr.de>; Sat, 14 Feb 2026 05:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935F629E116;
	Sat, 14 Feb 2026 05:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wsLWKQZq"
X-Original-To: cgroups@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD49303A04
	for <cgroups@vger.kernel.org>; Sat, 14 Feb 2026 05:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771048559; cv=none; b=XEjeyr20vs0vJGNedTw7rYwcDtFFyHDWAYUMEXCVHHuEHQWHEZhCTeMPMmc23gBUc7kSgQXmZydZaZ8oPw62PNrItxtkbfdQPmVfoAv3m4xpZhV6bHQc9ezKwHcrhKmc6DLDCCeBC2uQ04ohmUQ81RcSRRg/WQkg48Lv2O7K4hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771048559; c=relaxed/simple;
	bh=4p7/VLh1Ufevc16x7Gi0b+hrWBvqYZ5XQGRUCeLoNIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LVm7mG7YmZC5amwGd454JolMmDUFb2geBDRUJycQqsTx6KOpJ/Y4I8zkUkM/gG+TAGLoTPS21k7vbDzCS0Zjp/8HU7gT190qofl00XbgZALqgj0CCaI+UfNJQptFWgXH87V6r2++tPrW5gE6BLMvvfaqhfJUIe0XCH0la13O/1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wsLWKQZq; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Gm-Message-State: AOJu0Yysl+bGni1wON2BxIribhrCS31ONKDlnv5RjW3QO8NrN5F9gPCp
	n/6aLXV8Jq8Mak1R+3424kYTRmHMRJyje268kjY8UdvZEhhzALhINakFS4shX44ttqrt6fHlhAf
	MgLo2PygduIJG1qcbAiJama+43yQHPTo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771048556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4p7/VLh1Ufevc16x7Gi0b+hrWBvqYZ5XQGRUCeLoNIk=;
	b=wsLWKQZq1pDPecDLO9XHapsBy83FLgb3MVnLwmYFek7G5YzxCjiqtCFmIufV7GhF8FJexw
	JKi4C2YQSpexmB2+BopCXBR8qB2J8Z2XQRzcFHLSPyPbmRGaOPvp90uCXcaUlOHa6Sl0E0
	oKdTlo2wnqBT+YaNtnS/DNRORZ05X+o=
X-Received: by 2002:a05:6122:a06:b0:55b:d85:507a with SMTP id
 71dfb90a1353d-5676a8af2fbmr1301332e0c.7.1771048549285; Fri, 13 Feb 2026
 21:55:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260213-memcg-privid-v1-1-d8cb7afcf831@tencent.com>
In-Reply-To: <20260213-memcg-privid-v1-1-d8cb7afcf831@tencent.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
Date: Fri, 13 Feb 2026 21:55:38 -0800
X-Gmail-Original-Message-ID: <CAGj-7pURg5F_2zMAWseutKTKoAdzn=8fsNSqUsoNCWyurbFyGw@mail.gmail.com>
X-Gm-Features: AaiRm532OGRhhN1nv7-_o6WBJNYSsEZ__DUHnFfvG3RnhRwGE89mcxLD7x9Q6us
Message-ID: <CAGj-7pURg5F_2zMAWseutKTKoAdzn=8fsNSqUsoNCWyurbFyGw@mail.gmail.com>
Subject: Re: [PATCH] memcg: consolidate private id refcount get/put helpers
To: Kairui Song <ryncsn@gmail.com>
Cc: cgroups@vger.kernel.org, linux-mm@kvack.org, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	Kairui Song <kasong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-13957-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 9A57213B2CC
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 2:03=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> From: Kairui Song <kasong@tencent.com>
>
> We currently have two different sets of helpers for getting or putting
> the private IDs' refcount for order 0 and large folios. This is
> redundant. Just use one and always acquire the refcount of the swapout
> folio size unless it's zero, and put the refcount using the folio size
> if the charge failed, since the folio size can't change. Then there is
> no need to update the refcount for tail pages.
>
> Same for freeing, then only one pair of get/put helper is needed now.
>
> The performance might be slightly better, too: both "inc unless zero"
> and "add unless zero" use the same cmpxchg implementation. For large
> folios, we saved an atomic operation. And for both order 0 and large
> folios, we saved a branch.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>

Acked-by: Shakeel Butt <shakeel.butt@gmail.com>


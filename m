Return-Path: <cgroups+bounces-4675-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5D2968F0F
	for <lists+cgroups@lfdr.de>; Mon,  2 Sep 2024 23:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D101D1C222BA
	for <lists+cgroups@lfdr.de>; Mon,  2 Sep 2024 21:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3FB15666D;
	Mon,  2 Sep 2024 21:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RNeVQhL6"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0AF1A4E6C;
	Mon,  2 Sep 2024 21:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725310974; cv=none; b=kTXPciy9EKbmiVDNCgflS/Ltrdbf/kx8VPpwdLTGthwpJQ41xm4/VlgboaJahIRCo/tpYfML9INb6RubsvWfdkiOspWfBrJQ6ARqfJtYvhml4vE3SLpRuNh+MMOm92BZRTQQPhuyjhHuChTPglq1mR5iAWH3zGbyuaDC43KdI8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725310974; c=relaxed/simple;
	bh=qmUm/SLESS3Ku1lLFFuoU2gDnj+R64XXYu5wCxKeIPg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=d6k/hgE99fKwfDtfp+Mo5Al41CuxLRkO2m3MP55WcDkGReFHtl6izs9/2iONclvcr6BlexDjm06N9QUX/gTpqfpp5Ut6uZWwbFNAtzkemDhfXka38uUfHaKXPSEbJGe84rfCz1TdFHqtBf1/ttV7z73oazjl+u3+ZOV6sLB0rRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=RNeVQhL6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA96EC4CEC2;
	Mon,  2 Sep 2024 21:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1725310974;
	bh=qmUm/SLESS3Ku1lLFFuoU2gDnj+R64XXYu5wCxKeIPg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RNeVQhL6YzIxWcUl1Bp2L9TmSjs82a75OMYYBJqeQhkpvRFiyUQhKqWl3A6xwf3qF
	 3GDbh0dzdGsLOmnXZT9NzMTXDCOOEvV4Unk9lVra2sHKG+3W/zum/QtMbduIuMoGXm
	 +fZoqy8lGxurMIgfSYMIDzJtxEbjO9jLP93d31Lg=
Date: Mon, 2 Sep 2024 14:02:53 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Mike Yuan <me@yhndnzj.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 cgroups@vger.kernel.org, Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed
 <yosryahmed@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Muchun Song
 <muchun.song@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, Roman
 Gushchin <roman.gushchin@linux.dev>, Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v3 3/3] Documentation/cgroup-v2: clarify that
 zswap.writeback is ignored if zswap is disabled
Message-Id: <20240902140253.13be47a393ccacff3d728e32@linux-foundation.org>
In-Reply-To: <d305db940e461c92a618dd26224144a5105274b3.camel@yhndnzj.com>
References: <20240823162506.12117-1-me@yhndnzj.com>
	<20240823162506.12117-3-me@yhndnzj.com>
	<d305db940e461c92a618dd26224144a5105274b3.camel@yhndnzj.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Mon, 02 Sep 2024 14:13:43 +0000 Mike Yuan <me@yhndnzj.com> wrote:

> > +	This setting has no effect if zswap is disabled, and
> > swapping
> > +	would be allowed unless memory.swap.max is set to 0.
> > =A0
> > =A0=A0 memory.pressure
> > =A0	A read-only nested-keyed file.
>=20
> Hmm, Andrew, it seems that the commit messages of this and the previous
> patch are somehow reversed/mismatched? [1][2] Could you please confirm
> and fix it?

Yup thanks, a side-effect of turning a three-patch series into a
one-patch hotfix and a two-patch series.


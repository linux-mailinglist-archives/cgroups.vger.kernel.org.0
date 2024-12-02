Return-Path: <cgroups+bounces-5735-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 602819E0C1C
	for <lists+cgroups@lfdr.de>; Mon,  2 Dec 2024 20:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FA78161600
	for <lists+cgroups@lfdr.de>; Mon,  2 Dec 2024 19:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97AA1DE4D7;
	Mon,  2 Dec 2024 19:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ib0qiu8l"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C142AD21;
	Mon,  2 Dec 2024 19:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733167779; cv=none; b=l4CUJacrM0399/aIB4zff2F7gNDHFPiw/D78t/qMl6avvWnFDbw5vcL84UFclhkkG96aarWE+vD+24u2qstXNDqFqZBOuH4rTf6YC2zYCgx35aa3RQo+bo9qcvb3p+gsu9D4chyvcepC4SgQ9K/BMajJfCrsx55B8wC6UX32dTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733167779; c=relaxed/simple;
	bh=8xrzqyS10xGMTwkWM0ZBFAfF53qLo6Ora90vofptx1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wdr2qBiUQQQFwitT7m1jHmbqTfrmiO9tcHNPPD3FdncptRl9U0DGw1DvwbCgilhMMuyUc/SqOnS6i2YxbTwWeWHJnqiHsN2l1D8yfn7NYGQEdc0mc2+BERKD4VEZJadDv/FI41bsDZ8PDtrO8wfSMY+Ox47PwF44M/MuE8KfQr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ib0qiu8l; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6d88cb85987so25175606d6.1;
        Mon, 02 Dec 2024 11:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733167777; x=1733772577; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8xrzqyS10xGMTwkWM0ZBFAfF53qLo6Ora90vofptx1E=;
        b=Ib0qiu8lE16xfZbPZ/b66/aESPN3xriVlW8aWBnsZtwd3f9g9Q5+Y1h1W/9ibHcEDc
         BFj0iFMHdoSVG7EF+nZ6ezQliJmcj7iDTR2QsL84VA+ecMiwTj1zgQ6B81+8FSMR9deI
         MCoXb7BQRR5MlDqOOHTN0WC/5s8620OURn71P1cHhooo+0ZQENIB2+poObA8T9tnqm2/
         RRDyvvAgqRfSwvDEVHnWYqf/6wdSTnPZ7xdoRSJ2M7fFvk97yyH3A3X+ZGoKz7jkKyBY
         rD8dc4VFcqBvcZ1j50rTFzK76VGW6DUm0uzaTMB1SEwEinbI8WuTfu1VfzFhKAarawfC
         1jbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733167777; x=1733772577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8xrzqyS10xGMTwkWM0ZBFAfF53qLo6Ora90vofptx1E=;
        b=CjutzhfutVCayXk9qg1s5f1BqNXqMuX2ytfw8LOgaSLBvHRqQzOOJ9WzoDYDrBwL8G
         OqEB4gPZGDFK4j51XIvBBBqdJ+Lq/+/tATl3eo2DgwvLpmbzXyV8FnIvtjJlOjNP3OFh
         QyT19zMbyW8oOJmW8dIcm4L2iGmUSUX4RlaRt8Ft7EO2XmtkGuRX8jmICNGYyCO/YfbZ
         BmAD4fWF3CKZ5SOzGbMXpMYXD2k3XfJsLB9izNLdpal2p5JtWb9RFRw/CELO+tBjAg+e
         8tg/R8vNUl+svzmaMzcZLx/inf2KUFUaLUBtQ6XZ4SlKTWMng1L76471GiEAuTcwZsE8
         /l4A==
X-Forwarded-Encrypted: i=1; AJvYcCUpNYP+HW49dP1MT+AhVetGU4JEFESG/gZR2lKviHKTjjDP22zoRPFIN9PxwChG9g5d/hEbHeTR@vger.kernel.org, AJvYcCWKjyE+q/Nw6YvY9N2wmJVQF//3UxCxVZnQehQ/0/yJTGns67sdMa44F92ggEgWEw5FkwVNDAQPNU4NLq/5@vger.kernel.org
X-Gm-Message-State: AOJu0YzvDPDo0B05i+xcu1L+c5+bAC7wVPBWfSdeCtfR6OJZvKlc7lIs
	toz7VRcLnV01fyp6GgGkiXtI31BggrhB4gPLBKqQ4R6SYh7ToRek5uMPYaW4lrWNqiUUPNl2Uw/
	xrqBX+OfP+UeWRua3KOukGuVIHkc=
X-Gm-Gg: ASbGncsC6rjn6suQkwhdlJNm7ZTvC61XeeeApx2WfseHVunHrZTraCC4UkAwsHIlR77
	VCIqxG3t0AljxEC8YUQ6ECxdMvviNa1FYZ8Ymc8LBC1saOlI=
X-Google-Smtp-Source: AGHT+IEXJeoKT2zRJJd9fucPMIMzWYpgG7ramp/+EBhfzTABaWBnluvLXoeeKLZc4kCHRWcUcv60G2ddLxZ+NR0/8Lo=
X-Received: by 2002:a05:6214:403:b0:6d8:acde:8a98 with SMTP id
 6a1803df08f44-6d8acde8e80mr48098236d6.14.1733167776961; Mon, 02 Dec 2024
 11:29:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241129-list_lru_memcg_docs-v2-1-e285ff1c481b@google.com>
In-Reply-To: <20241129-list_lru_memcg_docs-v2-1-e285ff1c481b@google.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Mon, 2 Dec 2024 11:29:26 -0800
Message-ID: <CAKEwX=NnHrXxQoD1LH2VsTvA-qHBcL-armaN0A7MYmLFCAZkkw@mail.gmail.com>
Subject: Re: [PATCH v2] list_lru: expand list_lru_add() docs with info about sublists
To: Alice Ryhl <aliceryhl@google.com>
Cc: Dave Chinner <david@fromorbit.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Qi Zheng <zhengqi.arch@bytedance.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dave Chinner <dchinner@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 29, 2024 at 6:58=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> The documentation for list_lru_add() and list_lru_del() has not been
> updated since lru lists were originally introduced by commit
> a38e40824844 ("list: add a new LRU list type"). Back then, list_lru
> stored all of the items in a single list, but the implementation has
> since been expanded to use many sublists internally.
>
> Thus, update the docs to mention that the requirements about not using
> the item with several lists at the same time also applies not using
> different sublists. Also mention that list_lru items are reparented when
> the memcg is deleted as discussed on the LKML [1].
>
> Also fix incorrect use of 'Return value:' which should be 'Return:'.
>
> Link: https://lore.kernel.org/all/Z0eXrllVhRI9Ag5b@dread.disaster.area/ [=
1]
> Reviewed-by: Dave Chinner <dchinner@redhat.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

LGTM.
Reviewed-by: Nhat Pham <nphamcs@gmail.com>


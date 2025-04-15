Return-Path: <cgroups+bounces-7577-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC77A893F6
	for <lists+cgroups@lfdr.de>; Tue, 15 Apr 2025 08:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C3F63AF7DA
	for <lists+cgroups@lfdr.de>; Tue, 15 Apr 2025 06:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122202741B8;
	Tue, 15 Apr 2025 06:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J7xE2MdH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Heuai6nt"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627A619E7F9;
	Tue, 15 Apr 2025 06:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744698659; cv=none; b=dHRafh9hXU/l4TsrDLhwv7UIFepMeIcUCnpWwZIz6QJp+iPSsJEihaUtL0oD26fCcaE1qG87P9I0EDNKaX80UV1NZlD1GZMKn2BPUsZJ6qGZtbNsdHmEX2QGPO5T2QIwOzIIPZ0fZdt7mUaptzK2Juk33CYXSUBWeQGQPXanL+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744698659; c=relaxed/simple;
	bh=IE5DnVpdF1de3XX4dQ8FvyhXAn2YbDi95QhoG0JcATk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sKnugQSsKU6C837dCK7y4EQfOL2p8VXXn6X2t3twKLIhZHhzKNGv6QeQoZaNG/QWKtgBB2+YiLOVDrXzNaDoiDBtKeejJh+bGtvvcEz8IQ5Ag/9x7/Iz+s7lo6wzUj9wcDOlXsd9iRtAgUvPIdoOviDDo1BNkK6zDaDLRi8D6C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J7xE2MdH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Heuai6nt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 15 Apr 2025 08:30:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744698656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IE5DnVpdF1de3XX4dQ8FvyhXAn2YbDi95QhoG0JcATk=;
	b=J7xE2MdHqfbP937+Ww4wixg/L9FtvnUCY3IgLnh+pagK1hPayeHnGws1e+3HRb2rxdtZ/h
	xUvQB1b689ADiCmV0Apmyx3PO0Xplrczmf0iRBGZyX9ztfnUjQM94joAK2HkXmb0d0CEMn
	E7Uhq8lkT3ksAOu/IBd3zRxelazvvr2rZ6782h3MmIaCOWb7afO0EwpbR+mZkWcUB8AuzW
	m8HOBnj01+yq0pWY8LHJCxmddaw6JGraDdPwjIOMTyuPyiGbtT9mr4/LffoaDfFU4WuacG
	TqUL4WCi22ZwMgfZiDHPnG0XKt1KZvZgibnFnbCP3fMfIkayyq412AjAOqBKQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744698656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IE5DnVpdF1de3XX4dQ8FvyhXAn2YbDi95QhoG0JcATk=;
	b=Heuai6ntnKtatI5XsqHCHtmvLMSvI1cTyDEUJtoddyiOnXDRyKjhIzqhYBrtrHbCbVY/5p
	DWUkNrIGZFQccwDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Yosry Ahmed <yosry.ahmed@linux.dev>, Waiman Long <llong@redhat.com>,
	linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: decouple memcg_hotplug_cpu_dead from stock_lock
Message-ID: <20250415063054.jerbqGF8@linutronix.de>
References: <20250410210623.1016767-1-shakeel.butt@linux.dev>
 <0e9e2d5d-ec64-4ad4-a184-0c53832ff565@suse.cz>
 <CAGj-7pUxYUDdRGaiFon=V2EG+3Ex5s9i7VvWbDH5T0v-7SE-CQ@mail.gmail.com>
 <8cce9a28-3b02-4126-a150-532e92c0e7f8@suse.cz>
 <CAGj-7pXRmG2D+5=yj-5uuciiNccWws6erBg_hSm9S6coEhN+3Q@mail.gmail.com>
 <esdt7fygdyzxxlb7ql6qzwqydzokmfi4uxkfwvxiqedff5wnxl@n34muduktzou>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <esdt7fygdyzxxlb7ql6qzwqydzokmfi4uxkfwvxiqedff5wnxl@n34muduktzou>

On 2025-04-14 10:55:31 [-0700], Shakeel Butt wrote:
> Vlastimil & Sebastian, if you don't have a strong opinion/push-back on
> this patch then I will keep it as is. However I am planning to rework
> the memcg stats (& vmstats) to see if I can use dedicated local_lock for
> them and able to modify them in any context.

Please don't use local_irq_save().

Sebastian


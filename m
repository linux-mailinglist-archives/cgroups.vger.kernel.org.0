Return-Path: <cgroups+bounces-17146-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HgsSFWlUOWrHqgcAu9opvQ
	(envelope-from <cgroups+bounces-17146-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 22 Jun 2026 17:27:37 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 588226B0B68
	for <lists+cgroups@lfdr.de>; Mon, 22 Jun 2026 17:27:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=GYEhX3sV;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17146-lists+cgroups=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="cgroups+bounces-17146-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 83F41300A262
	for <lists+cgroups@lfdr.de>; Mon, 22 Jun 2026 15:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32CE83911B5;
	Mon, 22 Jun 2026 15:27:32 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46B9376A10
	for <cgroups@vger.kernel.org>; Mon, 22 Jun 2026 15:27:30 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782142051; cv=pass; b=ZXaZT9OadJ5wA3n4b0pn2jSVYHPTR8ZBYvhBM6i1p6ChJvdw1mgA5BMjByC7g8DJLoXR5l5NRhrtYW7QgN0CrwkWwpIBMjhUaAlCEak3EAfL3tRIYdWPzORz0DA07G6oQ7gaTQy0gGpZXWNjan4IAUVAE/AFjSp7rjuZf2+Sxbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782142051; c=relaxed/simple;
	bh=2uv6gQ7GKYPkzFwi4lxaTpmi5E/Y2YNpE6234rGNOfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sZTxP22NI+9dBCf1QBhcrQ6BJukDg+3hKV9W/lmLjJ9YGVE2mlmzj+J5cYAkz+KM/GIa2GsnvK59OTfkywmDCLDSj1TYNchkVugQaSd0WwozRnbNHuam83nhaXclUL6v9aWhIZurK8LYGww0xFFosKgxoTseZ5Nq0Co8YVqluLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GYEhX3sV; arc=pass smtp.client-ip=74.125.224.48
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-662ba4d33ecso325577d50.3
        for <cgroups@vger.kernel.org>; Mon, 22 Jun 2026 08:27:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782142050; cv=none;
        d=google.com; s=arc-20240605;
        b=WUHSl+Cr9tT8jBzhlEaW4Yx1dY4I7KSup9AVUMqURfsrcWy7yiOPVtmg07lzI9hE06
         p/EB0b3MuVqNyVl/AoEFM2ODW/yd0tfmCaQTcZBTQzLtfufwDH6AqKj56sXkjDP4HMtz
         YBixJbyshj12SqC54sgx2O/S2hVtm/9JmyP4IZHdJTSwRisC/1mGfd5Bc+ME+U76zEgN
         h9d3KWOJAB4xn8DQVQ+w0AS0C2pGlk3IoFM/7Dy1MgBR2aRECB7PSyv2G8jRrluQ9vA9
         HR9vASRjZbSMKFjsxsyKGQE8vVf/PXZ0C8HWjgZlwUDtHNeok+9wthOfEuZqhU40otZw
         mWsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=pGyvBAk8euMcJ38wECstDr/70ytuyfnKpcrUWwgIxnU=;
        fh=7ONBPvd+fzjlu1iivyFttcVlDtg1OXHsX3IOrkTM99Q=;
        b=jIxSWbne79ebv9IxXhzSGBxsZdqH1jBfMbqiE9Q/U3M6YY/obpjs+QXboYvN4bt7v9
         +AosJw+L3UbR90hU7KRjsNjsTP6V8QX46ekfbpjlSLamcHUhyZgvUfeF28hNJyeYP1jY
         x5JXmR2rnsSzFcHxJP4+CHCyW/PK6G0EmrdYOYi3pYpFDcQ9adS2p+pYB7Fr1FGPyZL1
         yulMRZU1YU5HEp32Rx2MmSpPXC1HeGS7ud7gIVcFqqKySSRG/qH7ix5VHFTUJLUJvVPd
         pcCxlaMcsOceeULmAPMbh/1wXGn8MpaHJpKDXMm2neqS15q5E0RfIPrISNnTAJZSMeVQ
         SqVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782142050; x=1782746850; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pGyvBAk8euMcJ38wECstDr/70ytuyfnKpcrUWwgIxnU=;
        b=GYEhX3sVHL3rM6tBpinPUWu00QMXv99i2sjPddxIFpMtJchiznyFJAqPKoqMbvcfwZ
         f+Hf9o0MXtBBNswhl7Jay4zf+RRz6abK6N5ozwlcgMc+Ll6+RnKfjRKyIgCZjP1xhV+C
         5qYjH5QtgadYmcuPVIeRd2HhFuHnq7RdDlOefxJslBsPFQTERAuQl+fDs65Z2fbiGJP/
         X4v7WnC/F+bkIYD60YT/gmbhPI/PGTlkTyUjAiZm6IkybUVtborawCp1amccTlorImRD
         F71JJ+uJx9nOu26SUF/MuOsjIfnEo8rAjGVv1GU7yCCbGRlpOoNIWeVvTT74Yf+wYo2d
         /loQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782142050; x=1782746850;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pGyvBAk8euMcJ38wECstDr/70ytuyfnKpcrUWwgIxnU=;
        b=MH7nr+9cfrC8iucgLtJgXwFc3CYkM+b6AGoO65OMELLElZP8k5U22i38VlmZ6QT/r/
         1UYyoO6Pb6mOI1WgnM54dEb/5hx/0ZFXI/g8YPEAEt4q2wvnwrYaW5X8e+qeifAIgJy6
         6tpagj+Afa6Ur45PP99LyXQ1zgXZZHmJpOHqFjGY1ciUhyTIxmvsnw9fxq4xcc7Cbw9Z
         vibjxk2thEXy4FhSnIRnAfZ56ZVgjMuEYrt/Ru1qwUh8dmSiG/RaZVZA2Yv763Io+y4a
         F532M7evleRrwItm8IwgmMw5pLEbfbP+u5mByxni8gaWYgaHZ2EbR/pNvq2IwlMYfQ3E
         W5xA==
X-Forwarded-Encrypted: i=1; AHgh+RrtlfXKYxuJH9zTaWOgsxM4uWMqyAeAMLu9OFVc+ZY8GDKj11VlEzuR4tLUDco6K3+G32ltwlcn@vger.kernel.org
X-Gm-Message-State: AOJu0YzGgzmb6BsxSo6m0GCTAOcqR1oo0rHhGMRPLQz6SysNljaZ4d9h
	BgX6FszQTyIObaUbbyTyzIgGj2bnNpOWCmGMkIAO/QkiS2xrShT5SglJvXN7uTW0BHBC4LycJaS
	EaSv8fSEjjn+Vta/cYHKnievAk4M4tvc=
X-Gm-Gg: AfdE7cli1W6fVCwC4t2ZFEqC+p0I+USpYvc8K0W8FqWP7oODevGBZuAoLKoAGLx/62A
	zYGFoSIfT8XdLGOXg5d7Q+kv5Dj4F3a6DFiQsnOil8gR4n5Rt2SeKq3HaDYiUgWqBWh1vnJwa/9
	fqisnZTJjrE/RJaB+fWgg49vVABU/m/h1MSts1UzDWwID+GePEHVgwZPXq3SgQ9C+u8G9H+/pUB
	UJ2gZ8FDDxuzw0WplI1GDODTqXWAB0RabyC7jHF1QuiPHwTYav5jrUIkF6AmTEb1rMUxEfAM4At
	/yUdkpuYCK+oOZlRWyWlEIUVBT+QRWWfbZVpKuDlZQ+Amo/zhhTzbrDeeVGTNg==
X-Received: by 2002:a05:690e:150b:b0:651:e194:5d07 with SMTP id
 956f58d0204a3-66350b6eea1mr765486d50.7.1782142049628; Mon, 22 Jun 2026
 08:27:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260620122751.388770-1-doehyunbaek@gmail.com> <ajlLhFnMZGoVxLE6@localhost.localdomain>
In-Reply-To: <ajlLhFnMZGoVxLE6@localhost.localdomain>
From: Doehyun Baek <doehyunbaek@gmail.com>
Date: Mon, 22 Jun 2026 17:26:53 +0200
X-Gm-Features: AVVi8CdlAu8C4EXvmIAbRj4BjT5WXnuOSLLYU3ZpM_yDiQWBdekM0ERXYkiczxY
Message-ID: <CAN-j9Upy=thswORWaU+QxuO2i8uJKrZxcLpt5umP5QGRhpwqaQ@mail.gmail.com>
Subject: Re: [PATCH] Docs/admin-guide/cgroup-v2: fix memory.stat doc details
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Yosry Ahmed <yosry@kernel.org>, 
	Nhat Pham <nphamcs@gmail.com>, cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17146-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:mkoutny@suse.com,m:tj@kernel.org,m:corbet@lwn.net,m:hannes@cmpxchg.org,m:akpm@linux-foundation.org,m:shakeel.butt@linux.dev,m:roman.gushchin@linux.dev,m:yosry@kernel.org,m:nphamcs@gmail.com,m:cgroups@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[doehyunbaek@gmail.com,cgroups@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,lwn.net,cmpxchg.org,linux-foundation.org,linux.dev,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[doehyunbaek@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 588226B0B68

> ...but what do you mean by this?
> As I'm looking at the code in obj_cgroup_charge_zswap() and
> memcg_page_state_output_unit(), I'd say those are pages and the docs is
> thus alright.
>
> Thanks,
> Michal

Thanks for taking a look.

I agree that the counters are pages internally. I was talking about what
gets printed in memory.stat.

The internal updates are page-count based:

    mod_memcg_state(memcg, MEMCG_ZSWAPPED, 1);
    if (size == PAGE_SIZE)
        mod_memcg_state(memcg, MEMCG_ZSWAP_INCOMP, 1);

However, both zswapped and zswap_incomp are memory_stats[] entries, so
memory.stat prints them through memcg_page_state_output(). Since
MEMCG_ZSWAP_INCOMP is not special-cased as a raw count, the stored page
count is multiplied by the default PAGE_SIZE unit and exported as bytes.

    unsigned long memcg_page_state_output(struct mem_cgroup *memcg, int item)
    {
        return memcg_page_state(memcg, item) *
        memcg_page_state_output_unit(item);
    }

Separately, this matches the existing documentation style for zswapped,
whose exported value is described as a memory amount:

    zswapped
        Amount of application memory swapped out to zswap.

Since zswap_incomp follows the same memory.stat output path, I think its
documentation should describe the exported value as a memory amount too.

I also boot-tested this in QEMU with the current tree and zswap enabled.
With incompressible pages pushed into zswap, memory.stat showed:

    zswap 87822336
    zswapped 87822336
    zswap_incomp 87822336

The zswap_incomp value there is byte-valued; it is not a plain page
count. It also matches zswapped in this all-incompressible case, which
is consistent with both being exported as memory amounts.

Best,
Doehyun Baek


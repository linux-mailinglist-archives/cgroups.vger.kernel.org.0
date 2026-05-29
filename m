Return-Path: <cgroups+bounces-16459-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UB2jIdPuGWoX0AgAu9opvQ
	(envelope-from <cgroups+bounces-16459-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 21:53:55 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD86608139
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 21:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C48F6302DB60
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 19:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C30D3A4538;
	Fri, 29 May 2026 19:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="quPQI1n6"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2539E332610
	for <cgroups@vger.kernel.org>; Fri, 29 May 2026 19:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780084305; cv=pass; b=qVRHPSuT5qqIT1g/6h0XC+Llp7o8mb5z6AdHJObH7dUViZTLEdTzH1WV94blC3UgWAM1ThUKxCW97I4yfCGDKDZ+hiXxL32AOhoMZKqx3Mmbdqq5PAq25iuXrby3lJPL+MsGJoSuRDDoHNdhWpVHOA5hk4BvkMQ16lLjnRVAcNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780084305; c=relaxed/simple;
	bh=vnofybMfKXc73Z7GzMMBieo9YudKdcjIw1E1DXfQBmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uA3/0ugNZlSM690j93giPyMg8d5POvmQaZI77z8f4S2Az/uMbu6/zMi4CPVf1R6s31geH7T4kkU4YTTV7JMf/+Dq1/IY5KhZCrOeSjsb4udOO1VaZIgeQKlWpKlKlxbpdnDoUEP0XUqxYKPmz6/VS4wv3hnOxLAawJxygcAghtU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=quPQI1n6; arc=pass smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4903d5c67bfso47395795e9.1
        for <cgroups@vger.kernel.org>; Fri, 29 May 2026 12:51:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780084302; cv=none;
        d=google.com; s=arc-20240605;
        b=K0OX1VkXjpAVsSe3FviyZs/PZngDKjOzHY9/26C5kNfHNlQ37TP/qDTKT89uLJk6do
         usime5FGQEwZH6kGgw5T6SLBhP/DfIuwkzvXVu6k5on/LKdtiXbsjeRvAUZtkOjK6y3t
         SoS0O4jhwahPJwBouw88mCGton5u0er8BMWkThVwS1VB6XswDXG/3GJZqrszF7qTHmYy
         hwJmu/2v5nNc5ewza9bZTw4KeA5dGcXlu8a0qd9/R3MkYtVyUTLkCEcQ3oIirM1YV6PV
         BPKFLwPdSp9VLqBOVbxwns2fYfaAvG+UX/VpSzbGjpeQpJiW/VIuNBbGRbvvklxeyWvt
         0KSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vnofybMfKXc73Z7GzMMBieo9YudKdcjIw1E1DXfQBmE=;
        fh=o1sMzCObt/HN1eCRH1mJC35NrQm7nb8rqIHvL0Z8ACU=;
        b=cCxJskfJNOB/w+gLcomrCedgD1c5/zpXEscBtjt6cDbSSJ3ghk+6S79zRgW12f/iiu
         Kz8xwdsSk0dcz7GyvD4hvC102a3nN7gigYis9T9iOm7jXGpt2W14INZANSrPWhF7WHHX
         Kh9VyF+iTLFD4qt8fRNNZmNOWiT1vwfXSfcsqHUPbJIXP5udIrPBDDZXv1vCMduWK+bp
         ql5XDiYmZp3SvxSpOxSBSNQTz4EiAoaE+u6+0ih+ZCA74bZBSmbLQwZl81GroIfUip4t
         NawbwhhXNk3qdyDmaMgI/VUaUt5tGVe9gvi0CRuaMqs3JBktnxSxPqbbnDCAvj6oBrkA
         Zulw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780084302; x=1780689102; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vnofybMfKXc73Z7GzMMBieo9YudKdcjIw1E1DXfQBmE=;
        b=quPQI1n6nf5w0xxhvY6xcCmtxjYGWazoulzG9Cr2fiz8HEjNhnIULebkI5qVUtQ01P
         txjZ6v9bkodVFhERU3EAqGmtsCEJFMJP1cX5CQLP2AFJtXMlLxAZGtsxK8U99e/Ug7Aa
         0kDbzYHbqD4UaznA6Kb4/Q5jqxsZXpBA0cVJ0W3HvJMAqgSuebQRowKXWi/EB3lwvF78
         YkeMJm/z5GRLp2kgs3pddKIPHieItj+nDRnRV9e/MdAqE8FKAvBMcJGOpBevzoLQeWK4
         5BATYU527+6x/yHtKk+GAsO7Rgs/DIpZNfjUOe9chxLHtKgFwvlFI7nf8DRlMjtexot6
         FAXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780084302; x=1780689102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vnofybMfKXc73Z7GzMMBieo9YudKdcjIw1E1DXfQBmE=;
        b=cf/hpaV8cUKDy4Mdw70WiG4MNograRxAeMvrfE2bhzSc7T8OHYfx86qfg0hqgIsGnj
         YsSg4AF0+XdJoICJR0wKUaQF3oZuQcyNhx/C4UKnWEpHWWU8rbLF5mMpFCyO0dBBeKtW
         f6b4cL+Kz/ogM1/SGhSs4noZ64NbQFeMuWv6hmZLWZRbs4N19mtCSHo2BrmRO2m3+7YI
         dvDCm21yGFqPYSZmBvprFAUua7NXdO43tVD+H4SmNmUilSfnlF1tF0KdFrfpkOlVWLT3
         DBtTZQR0g2a80JPj1jQCsLQVeqNND5U/91QHLstAyDnOGRXowpKWeZgu1ribFH4qxyAA
         VsQQ==
X-Forwarded-Encrypted: i=1; AFNElJ855NHmVbLsFvJv5Jgudv9e51X/NtILizs+E8tKoSHoGGUWhvvv2yaD3viHnRBEijUN8YsxRyHZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6nTPWnmrg55ooLuM6Bg5B9pr3CQLbHhF0Z1QsQpID5zM365/B
	EuRAkg/zoNzmr+NrVi1xbZqK1fgM+zlzCJJfMhKgU72tSY1QAQboogOTcJVQg8J3AD5ZVJpRNkH
	+d/bBpLlXWhczGIme+H2fqSaZwTOlioc=
X-Gm-Gg: Acq92OEwXxu9H0AkemCRuZL6XChsjBVxmJ1Gvapt06tCtyvaCaVoovRygIU+ikZ1Ult
	izkB67AQ2iXlYpubHvYkheqmSdCIvKGsIVYy3YCT9mp8Fg7GtRPh4FKp9z/FHaVKj13loAsd0T6
	SF+McpwUSLTUsyCwys22X3y1hmumqblMmoMEgEfxuz8FDDFiKsLEbsI5MOYZ7V6m1oKAABKlUax
	gSpUtph2XKA7D45ogGBkbr8g9G23mY5jjB3VwBlwRi7zhvZqO3xjeUpNfmmzb4wnYZIwSnIpOSW
	bMU7vjSlOg4XBOXoP8dBzC0taKujGK87hMN+Xv5MaZN8DjFB0C0VV2k5qIYg
X-Received: by 2002:a05:600c:4f53:b0:490:3b8b:6ba2 with SMTP id
 5b1f17b1804b1-490a290bbc9mr18998515e9.8.1780084301582; Fri, 29 May 2026
 12:51:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526114601.67041-1-jiahao.kernel@gmail.com> <20260526114601.67041-2-jiahao.kernel@gmail.com>
In-Reply-To: <20260526114601.67041-2-jiahao.kernel@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 29 May 2026 12:51:30 -0700
X-Gm-Features: AVHnY4L7tgvKRX4kdfRx8qsBxz-QbD35FXrun4oqca1DzRXBvrMnNdcuSN4_ihs
Message-ID: <CAKEwX=NrL_t2BiA7i9D-jUdzkTu-pJDy++0uvxrysetMc8aRUw@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] mm/zswap: Make shrink_worker writeback cursor per-memcg
To: Hao Jia <jiahao.kernel@gmail.com>
Cc: akpm@linux-foundation.org, tj@kernel.org, hannes@cmpxchg.org, 
	shakeel.butt@linux.dev, mhocko@kernel.org, yosry@kernel.org, mkoutny@suse.com, 
	chengming.zhou@linux.dev, muchun.song@linux.dev, roman.gushchin@linux.dev, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Hao Jia <jiahao1@lixiang.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16459-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,lixiang.com:email]
X-Rspamd-Queue-Id: EAD86608139
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 4:46=E2=80=AFAM Hao Jia <jiahao.kernel@gmail.com> w=
rote:
>
> From: Hao Jia <jiahao1@lixiang.com>
>
> The zswap background writeback worker shrink_worker() uses a global
> cursor zswap_next_shrink, protected by zswap_shrink_lock, to round-robin
> across the online memcgs under root_mem_cgroup.
>
> Proactive writeback also wants a similar per-memcg cursor that is
> scoped to the specified memcg, so that repeated invocations against
> the same memcg make forward progress across its descendant memcgs
> instead of restarting from the first child memcg each time.
>
> Naturally, group the cursor and its protecting spinlock into a
> zswap_wb_iter struct, and make it a member of struct mem_cgroup to
> realize per-memcg cursor management. Accordingly, shrink_worker() now
> uses the lock and cursor in root_mem_cgroup->zswap_wb_iter.
>
> Because the cursor is now per-memcg, the offline cleanup must visit
> every ancestor that could be holding a reference to the dying memcg.
> Factor out __zswap_memcg_offline_cleanup() and walk from dead_memcg up
> to the root.
>
> No functional change intended for shrink_worker().

LGTM, if the memcg maintainers are happy with the overhead.

Reviewed-by: Nhat Pham <nphamcs@gmail.com>


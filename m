Return-Path: <cgroups+bounces-16935-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id K7f1KF2IL2o7CAUAu9opvQ
	(envelope-from <cgroups+bounces-16935-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 07:06:37 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0303E68362C
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 07:06:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=wNHy5xfe;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16935-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16935-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 014C930087AC
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 05:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6572F7F00;
	Mon, 15 Jun 2026 05:06:32 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E432356C6
	for <cgroups@vger.kernel.org>; Mon, 15 Jun 2026 05:06:31 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781499992; cv=pass; b=iNA3AgHVuncBmEQWBh8uSHMbC7SMTH2TnJMkt/RdqmwWisRcQmod2qizzNQkniL7TanHFjfe7hsWJWM//+0PQ6yxrKc2Kfp2t09WoxbLxt+U2+qLkhOd05LmMlGAHxkpJ+yWO8ZfxlHkryCkmHb4cLo/r3Xmhd5XZ3EixE15nbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781499992; c=relaxed/simple;
	bh=Jk7xxbhVE56zG/uWPAGorH8GgI9c7exGNGP42BIvXVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sE/Rf9bnqPiROrvHLr3G5PEK4UQnrO6lfGeqpP/ToEfN5rs+HUsQVlebqcaIMzojHs4zqy+RSE3rQ0H0gT7U0eGZzAZJV7UxvcngPN7ordrILaIPkH0XHv5qWOKqYvbLgmRI6lNny8m+0QwB2hf88fUjjzAvYZzFBUTbhwYDaG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wNHy5xfe; arc=pass smtp.client-ip=209.85.160.170
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-5177d1ff061so731681cf.1
        for <cgroups@vger.kernel.org>; Sun, 14 Jun 2026 22:06:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781499990; cv=none;
        d=google.com; s=arc-20240605;
        b=data/Y7b58+msN6OSPJLWI8BEfvOTvdHomEBI189yOHDevCN6Z/EK23g8qSiOW4nj+
         n2kv9XMPQzl5moqYQ9uW8dc+HU3sKV2z+10+xAtNGxfYrnUGd47JiWAk/sB7oT5yNyBs
         8sYbI3pY3cwEpDX+d1iaBTZLQ2K+9rzVsvyQoMtkOM5XWDYi1ejfQTw4NF9tK5/nCRYM
         0b0nnsbWIkjUO1zKX3T9sNnDjcmVxDN21Tl81jJxt9c8/+QpsFtoNwyNVbsVh3lwOzm2
         rabaWV8+uqyOylYZgQaJ4XzpykQS/UE/CDIPmpIA1E+mNnmPu9UoMgIXKoJ7fY7fiMHG
         3UTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Jk7xxbhVE56zG/uWPAGorH8GgI9c7exGNGP42BIvXVw=;
        fh=by/qGUAVydg+IPEB2oO0G6qzTyHSH6iJg1NJOtmJZ28=;
        b=Ab4EMiAYVbpDzpilluYFT/pfLow6Q6AAeXZNgm/qiueOfaiMDlNESIb86r1ZVr4k2S
         05dquauUi/RR1G7Onq7UELQnNWHvaW9gTuKCjwkYpEyzOrxTHTP8RGRy/LxRPGL+Hksh
         ZEWOZbOjI9sOxCDy+G7+TFBMPkiIr4rbDpqeQ6KvSFmG5vOQfyZScaAAZKQZL9ZSK/+z
         ZLFljdpP61hVBPB1xXCIEqa8I6ykWQ/+jtFirlwJcb3fVky72EZmSTsxeeYIHOLwwNYu
         Kt1hZSsuqfMInNdtrAlktfwGmHXFn/zB7/BnH5TCp/hEUPSCC02a0p2NLqzU7Rf2vd1H
         7VWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781499990; x=1782104790; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jk7xxbhVE56zG/uWPAGorH8GgI9c7exGNGP42BIvXVw=;
        b=wNHy5xfevsl8wNh4gwIHgCDS3WLBEaCyvNcs/HRMf5NkkYGJGdnuVk/eYscgtj6zQC
         lmP8RdUFbbCJNUQewMz7n/IckEeRB5JK5dQXD+8cYMHBNnDH4C7Got2KGACvS10dz2Y2
         kZETC3iVrC0DICPlh4xeFpvMzEkSFtyKqmjMUSgYpHREQsp+j4P2zLgsjgbO66RQzn1y
         ltKjsa/QHK4HUggOftIwqxZKpGozmXaK5jYpbVGeGNM0t4Ba6z4oN5fCieat40xtg4SG
         A8Jwki0D5kPlrnebl9gU3rv5k5l4S5CcFxQveat0+S9HTBIRJFs3kW8stQfn9uVU+m5Q
         X6Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781499990; x=1782104790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jk7xxbhVE56zG/uWPAGorH8GgI9c7exGNGP42BIvXVw=;
        b=liugUgyBbw5YJbeuBOK9dlKU7FOGfIJ2oygTG25UN9DRRMYcHuZ5OKadaTGY43R+s1
         YVLqZgAFG8fbAALoVlNRTZcdzBvPM/MM0RJi8S9R3LhWMBDTrRp6XWF5ZKLlSsBcTZBS
         VvMMGTBwRMqDJLiDFvXQA+VYdPbXqpA2lNYpBpMaUosuzND1cg5U7oVPf52g8Yuv1YQ8
         J145ErEb642Npe482BLQmvjGX8O5NmwK2bFEJXVJqwsVGalJbdSHhdNqmmDmv+qLZncu
         D0TLbLt1fkkwMLnkbeGDaLSMlo4MRXHLh0CYIx4ukJSZep/JX61Fq7BbOfML4qkMnuDy
         E7cg==
X-Forwarded-Encrypted: i=1; AFNElJ9ZpdSN7tAKp5mJVyZeBrCA5L2oXGhX7PL76A/Fg06uN9+IcGbf8ecqlx6qKbn5rSR8BCfRUryK@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm0wIf8fma9GeLtqAAciUH4u8pCPNjUaN/j4mgvertZb8BIv+5
	tjGC8p0n8bNYB9Et4A9yOq7TMKWzt39uWq9AojcNYXYuprkPkgZWlk5s4Wv7AZ4Uv+lGaoSXn+n
	v8nuh2R8V2i29NTRZD+/0goIwCPKXbcByMiLZihaD
X-Gm-Gg: Acq92OEOkuY2a34aV0r6X2I+C51r8iYwR+u+OaLzh2rOs6mgb8rEug1f64sDsQ57zCy
	81R60Xj3TvgwfNsxZLkulPvfcuXF6y2mlhdStU22yiU110cqP8vVVhL6Eb0J7FOalpgJwLaQ9Es
	tfiywiCn4k9/B5IRPFdUlrtmgbwvHXmCo3Kjd0LasrDA/ICzWef+1tJ5f/RDVdJPYe1n4HgWERL
	7H3ryxqFmk6r/rBXWnJv4uFvSoVMgZFc9had1DBVFLpDO4qh1gZrjvzDFv1dW3bmNaHJdow3NMT
	YF/HMg==
X-Received: by 2002:a05:622a:258f:b0:517:6dc0:698d with SMTP id
 d75a77b69052e-519548691ebmr14774511cf.0.1781499989938; Sun, 14 Jun 2026
 22:06:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610-slab_alloc_flags-v2-0-7190909db118@kernel.org>
 <20260610-slab_alloc_flags-v2-13-7190909db118@kernel.org> <aiuthBHdDb0CNs3n@fedora>
In-Reply-To: <aiuthBHdDb0CNs3n@fedora>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 14 Jun 2026 22:06:19 -0700
X-Gm-Features: AVVi8CdcidaJaOvFORpuIYafyUSQzk1GYFvijlb7jrAGXeA35XFZPKAIkQsB0og
Message-ID: <CAJuCfpFQU=n16wZLVrJw-VG6hZzHo=bOtmPtCGGZrNxnwTj3rA@mail.gmail.com>
Subject: Re: [PATCH v2 13/16] mm/slab: allow __GFP_NOMEMALLOC and __GFP_NOWARN
 for kmalloc_nolock()
To: Hao Li <hao.li@linux.dev>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	kasan-dev@googlegroups.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hao.li@linux.dev,m:vbabka@kernel.org,m:harry@kernel.org,m:cl@gentwo.org,m:rientjes@google.com,m:roman.gushchin@linux.dev,m:ast@kernel.org,m:akpm@linux-foundation.org,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:shakeel.butt@linux.dev,m:glider@google.com,m:elver@google.com,m:dvyukov@google.com,m:kasan-dev@googlegroups.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[surenb@google.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-16935-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[surenb@google.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.dev:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0303E68362C

On Thu, Jun 11, 2026 at 11:57=E2=80=AFPM Hao Li <hao.li@linux.dev> wrote:
>
> On Wed, Jun 10, 2026 at 05:40:15PM +0200, Vlastimil Babka (SUSE) wrote:
> > The two flags are added internally so there's no point for warning if
> > they are passed by the caller as well, so allow them. This will allow
> > simplifying obj_ext allocation under kmalloc_nolock().
> >
> > Also it's not necessary to have the extra alloc_gfp variable for adding
> > the two flags. The original gfp_flags parameter is not used anywhere
> > except for the warning. So remove alloc_gfp and directly modify and use
> > gfp_flags everywhere.
> >
> > Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> > ---
>
> LGTM
> Reviewed-by: Hao Li <hao.li@linux.dev>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

>
> --
> Thanks,
> Hao


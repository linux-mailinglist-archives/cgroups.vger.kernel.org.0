Return-Path: <cgroups+bounces-15246-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BzDOAU53GkTOQkAu9opvQ
	(envelope-from <cgroups+bounces-15246-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2026 02:29:57 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1981C3E67C2
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2026 02:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3BB4830028C9
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2026 00:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146581E9919;
	Mon, 13 Apr 2026 00:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WCzh424r"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7041C1D6DA9
	for <cgroups@vger.kernel.org>; Mon, 13 Apr 2026 00:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776040190; cv=pass; b=qg3+hLUt6kdTzYc2KnnQgVhXtFbX357pnUZ76AcjGtLck32omZq4i0Ft/Wc+Kf869fFIc9lzjX3DMqEyG6So8Jc4ScBbeuWD2BncrMJmuSt/gora38IyV41dNz2D48e40CrM/I1m4VysWzQiZxUSAcLt4Z9R5g2KgGwjMGHmso0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776040190; c=relaxed/simple;
	bh=prg3U8HK731gOVXqc4EbhlCEjxMTyQb7yWGPWCz2KOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o3kiSavf50IeEDJ+YBCJHYuWttd3iKIa9rsZfmDr47EfRdcmspKw+0tp5oNJk8VC5PGWFBNy6qe7Ee5+7QsjF5MIJx2065gNm4/299UDFmw68pyIpkQI/bj5+qZhrO66h5SZcZPKhq7UwqfAxAdklBwFn6dfLXvi1O4Mi75uKdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WCzh424r; arc=pass smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43d76dd4ee8so513118f8f.2
        for <cgroups@vger.kernel.org>; Sun, 12 Apr 2026 17:29:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776040188; cv=none;
        d=google.com; s=arc-20240605;
        b=hnAHfJQjATq4wVibg3W1JFqCkr08F62fIJjf8cfjrTrMAnQHUhOkpka+XBTsYaToY4
         JQGMzigMwrnNZmdxZ/Zme+WbSSHCYM+UdQLyU7PY4lnenlIM/L71RCTLFq0YvscdGj/J
         M2t7qN2A0+PleP9QV5RIa4yxZpWA3aUfRYzx1pd4YVbfekbvL04ByWnRXOuCCfRJSQJ+
         5eqrUdqmjEXQFzBojHBe8dNjJLieL4iPIcA92bqQRKHLlhtP3QDmqBMuPAd/Vk0NvBMb
         v21pbHPBAZWHfPeO7MSA4zqpG/1RzBkYWqZrqZDl80hdxMd2Q8nkt402MwI2z6X06N4W
         /1QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=p+QXCRNJsvBJXHEfK6416uGa9fOl7qqDApTOq7sS6hE=;
        fh=0cO9GNCUGnAKW8I42ZaCwwJFdecGXvS7yI8wdjv6Hxc=;
        b=ai7DiH2EbUbL2xMwk+/jIopWQNZ8rlEa+zEoCyiAmNVuMomdagVpjgLJ1BUAd96vui
         CdDGs7q9PzqTkponEOSufRcTsa4pU2H+NI2OM197pJ4JW4CW+3OQ/8SgTf6phdPgGvtk
         BN/87RDp75mLQBje2OJYEOXvDmDPsJc52mRQXRPgOZf8dLlZc+w/kYYFxJnzkh1sWFa6
         b/cysnJPEIXg5Fc1kOEdFHR+Wpc4f5bZXDr/HbXwXlBUESwFYRenoRfWiCZLn55TalAD
         32RggihdleT6BjwACxrzmkTwB9qdzq+n8HcV8aW3kMi0FF9jmj6OsvnHoJkzEC6P8B9I
         uUUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776040188; x=1776644988; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p+QXCRNJsvBJXHEfK6416uGa9fOl7qqDApTOq7sS6hE=;
        b=WCzh424rX6dPKb0bSVGcm5pW+jzuAnvH6EU9fbQNxzNEXp5+T01LkyHK8YbNCN3v84
         BnOvsEvvmTZvOv83/WZB90yL24x78H1OnJtvvtZVpHeYkMBms7H+c6P8LhOr6r9iG/0g
         Xlp9FALPCLbDLun9h0C1CD3x7YCTyB6da4tuKKfy3mWbbf8qAnoFsdjHxCCClmooM9sZ
         bIeXGsPKLmlFfPducp0TxJEAOJNorKujne6nfwr8P2jvHrbcT1Kgqar3wLE22NXC+iZ9
         DXfZqqVGufpvPw46i6DvAJdK9bzlYaekIT6sCsfkju8Wn+JdAVY0ON7cSophOZjq98Tc
         0SwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776040188; x=1776644988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p+QXCRNJsvBJXHEfK6416uGa9fOl7qqDApTOq7sS6hE=;
        b=NdSfmObIIRxvrZFY2CeSyXPWkbJT2UaAUiPI04hRH479ZT9p/bk9JIgjYvB0OvYomY
         ZBd4+s1tQ5rtMBfi8SDnaFxIWD+Qtbeh9s9oZU3hqYe0EHkRfH7vHfOftT/W2JfbD+aH
         oAQCB1fHDm/RfD6d9wXlWkSXbAKt/ozlrMO/x90VD4dLj5/qWuxaOYFyeb/i2hCwTZvG
         VarjNV7m76UeqCLwwmrEX1ZdfYJiw5+Ba6eGFXI1sbgVYLsDXXVrPW0jD6YoMVL9TTXk
         Y8AYgam5ePEeV2UX+L9MC/EORCxOYEjW4tw3Lal2zHy7oDxIae3hPfOuo/e6qvCYFpMk
         8HWw==
X-Forwarded-Encrypted: i=1; AFNElJ90aQB10Dsrx+9qI8VSfzjUHFM0aBrIwoPtZwR69dep1StUlIP2XQSi803+cQdBDBEppXz7qNlT@vger.kernel.org
X-Gm-Message-State: AOJu0YxdyKxquNmFAk2kB2oz0YBGRNe/EClPxqrXU3uusxD38vHH3mJq
	/yF1u85y5612pOyARYUpMFUElJNkoBz76JA+38tJ0XmUKM0Wz/b6ju97c2Ecu+hQP92bW89OG47
	dILB3na9rdSgalu+5ROK5yRSVpZAZBXs=
X-Gm-Gg: AeBDietQLuDDjwEPUXweJFQ4XDVndINtYG8nu9zltdsesGOYRymSuX1qz6XnDj3wVD/
	af8LFURUp8EwNoRXn7uZdsG71tko4oL8g5+tEAiPYKD1XQMDyFRcFEmrdUIuqgshKQCJY4pu418
	nTqOeVgQVNDr/Drx6m/Zw9E34O9CHHGzqNvbsDd1Q606FTSGpWROEMn+VgM2PzGMjR4dhpGu27k
	E0FMjV+cWsJL6OmeivgqYCbzI/nXlYtC6Yialg+qNki7lePQnY3+avQ+6BXki+Yie3dfushlmGY
	ldcSe4b9PJvleXqL4xzHJwAejE78E5vVWtkMVw==
X-Received: by 2002:a05:6000:184d:b0:43d:7b23:bc99 with SMTP id
 ffacd0b85a97d-43d7b23bdd2mr577667f8f.15.1776040187608; Sun, 12 Apr 2026
 17:29:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402063714.55124-1-liwang@redhat.com> <20260402063714.55124-7-liwang@redhat.com>
In-Reply-To: <20260402063714.55124-7-liwang@redhat.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Sun, 12 Apr 2026 17:29:35 -0700
X-Gm-Features: AQROBzDA_W2wnhZr93RNMhtdQJumotHsjmSnSZPteOoUEt7sHLGd9BTXQt8gj-w
Message-ID: <CAKEwX=M150Hw0Ncs69SCWRr7J+vK5F0biotkz=MSFvFG3rgjow@mail.gmail.com>
Subject: Re: [PATCH v6 6/8] selftest/cgroup: fix zswap test_no_invasive_cgroup_shrink
 on large pagesize system
To: Li Wang <liwang@redhat.com>
Cc: akpm@linux-foundation.org, rppt@kernel.org, david@kernel.org, 
	hannes@cmpxchg.org, yosry@kernel.org, ljs@kernel.org, Liam.Howlett@oracle.com, 
	mhocko@suse.com, shuah@kernel.org, chengming.zhou@linux.dev, 
	longman@redhat.com, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Michal Hocko <mhocko@kernel.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Muchun Song <muchun.song@linux.dev>, Tejun Heo <tj@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-15246-lists,cgroups=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:email,suse.com:email,cmpxchg.org:email]
X-Rspamd-Queue-Id: 1981C3E67C2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 1, 2026 at 11:38=E2=80=AFPM Li Wang <liwang@redhat.com> wrote:
>
> test_no_invasive_cgroup_shrink sets up two cgroups: wb_group, which is
> expected to trigger zswap writeback, and a control group (renamed to
> zw_group), which should only have pages sitting in zswap without any
> writeback.
>
> There are two problems with the current test:
>
> 1) The data patterns are reversed. wb_group uses allocate_bytes(), which
>    writes only a single byte per page =E2=80=94 trivially compressible,
>    especially by zstd =E2=80=94 so compressed pages fit within zswap.max =
and
>    writeback is never triggered. Meanwhile, the control group uses
>    getrandom() to produce hard-to-compress data, but it is the group
>    that does *not* need writeback.
>
> 2) The test uses fixed sizes (10K zswap.max, 10MB allocation) that are
>    too small on systems with large PAGE_SIZE (e.g. 64K), failing to
>    build enough memory pressure to trigger writeback reliably.
>
> Fix both issues by:
>   - Swapping the data patterns: fill wb_group pages with partially
>     random data (getrandom for page_size/4 bytes) to resist compression
>     and trigger writeback, and fill zw_group pages with simple repeated
>     data to stay compressed in zswap.
>   - Making all size parameters PAGE_SIZE-aware: set allocation size to
>     PAGE_SIZE * 1024, memory.zswap.max to PAGE_SIZE, and memory.max to
>     allocation_size / 2 for both cgroups.
>   - Allocating memory inline instead of via cg_run() so the pages
>     remain resident throughout the test.
>
> =3D=3D=3D Error Log =3D=3D=3D
>  # getconf PAGESIZE
>  65536
>
>  # ./test_zswap
>  TAP version 13
>  ...
>  ok 5 test_zswap_writeback_disabled
>  ok 6 # SKIP test_no_kmem_bypass
>  not ok 7 test_no_invasive_cgroup_shrink

I assume the test passed after fix? ;)

>
> Signed-off-by: Li Wang <liwang@redhat.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Michal Koutn=C3=BD <mkoutny@suse.com>
> Cc: Muchun Song <muchun.song@linux.dev>
> Cc: Nhat Pham <nphamcs@gmail.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Shakeel Butt <shakeel.butt@linux.dev>
> Cc: Yosry Ahmed <yosryahmed@google.com>
> ---
>
> Notes:
>     v5:
>         - Swap data patterns: use getrandom() for wb_group and simple
>           memset for zw_group to fix the reversed allocation logic.
>         - Rename control_group to zw_group for clarity.
>         - Allocate memory inline instead of via cg_run() so pages remain
>           resident throughout the test.
>
>  tools/testing/selftests/cgroup/test_zswap.c | 70 ++++++++++++++-------
>  1 file changed, 49 insertions(+), 21 deletions(-)

LGTM. Thanks for fixing the tests :)

Acked-by: Nhat Pham <nphamcs@gmail.com>


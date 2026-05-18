Return-Path: <cgroups+bounces-16041-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +G+1FIRYC2oCGAUAu9opvQ
	(envelope-from <cgroups+bounces-16041-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 18 May 2026 20:20:52 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D77FF572289
	for <lists+cgroups@lfdr.de>; Mon, 18 May 2026 20:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E605030433BC
	for <lists+cgroups@lfdr.de>; Mon, 18 May 2026 18:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D92C38F233;
	Mon, 18 May 2026 18:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qwX7pkx8"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342DC38D69B
	for <cgroups@vger.kernel.org>; Mon, 18 May 2026 18:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779127936; cv=pass; b=boStNufE5DNLEE7eW0S/nw1S5yKYtzmtcW8Ww8PddRu3pf/xPK9qTB4f2kAJm/qNkXPJzVNmCffR8RFyVFTbdw5kZ8t3HM+EJj1aLueKKG2SQ6sqW6AYEoEUtt6gCBe9ef9Q6qRwDtbefGQ0AcfcSEyQQPaC2sK4BI0GXl/K+oE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779127936; c=relaxed/simple;
	bh=KZHpu577JJ1NeIVxaJiVGE/6LzdYayI5qTGrF3i8FQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EkzX0Kq0oLtAdxrviaTmSl71JqgecByVs0foaAT+VHdfmxUoNbc7QRSZjpqWnXlXGVp1Z1NupZVXf3hG/XRBcpBjKLTq5Eb4dVoTUCF5QlA+iipiqyiCb+G1i+9/w66wDIUPiLgiXGvw8YlBr97MkF5T0n2AesV0y1ex4UyX7Vg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qwX7pkx8; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-bd22b2abaa4so461055066b.0
        for <cgroups@vger.kernel.org>; Mon, 18 May 2026 11:12:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779127932; cv=none;
        d=google.com; s=arc-20240605;
        b=A1R3qh21B0FRTpi5qNTCbCwAjtd7/UruTW2U6920oLhXOJkb0oVYIySGLkLDFsJZrn
         uterl0r65EkNmgHRCzblocaDtswNqvIXsOI6riSiUfUh/7ZvaIPskOZuO88UJfJhwKZr
         /jFGw7EX7i7zG3CSLtyd8U3IuI3e9208ASUAjj/B/w+T1oug5GJrbHflXyfZjPqTiDfo
         kyPw3IDNw0Nd1IFAAtMJfeHOK8BUYcv2EPGZeQPNmXhyuPMVf0AnQ39k7dqG005bqeWA
         VGnw11jgJgNSbqCln1Q5dVPEFZnd2kwlmFQ+aFPjp4/jpdkeUI1GCMiWOxE2BlARFE74
         Mlsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KZHpu577JJ1NeIVxaJiVGE/6LzdYayI5qTGrF3i8FQs=;
        fh=bqgx6/ewbTpnd8f3zqoSmioh1CbmbhWkB+eKp9umZkc=;
        b=fsCa8a7mVhi9x/D1cI6j2rv+uwmvv6kD35PPC2lAZdrYidykS6zxdtLHdpmzmguGP6
         hcLxnmAxBY/L4321pBOfrhaQkSCjR+PtWCcrVIc/6Gsb3GCdnN8c1sWGNZu8rfKwUh2w
         Ns23iic3hAYEkPQlDcjdl3BFWl57CAS44qWx9onhk5ufVMbO2je7yEi1ILAoXgMdrlRd
         w/gZeE7roMEz3aUaCWzWDzJEltKu5gPv0CTG6LGS+BSsBqVeH0k5DSBADGUgyuVxzlhw
         w0nQXRNd74qtyMMT33Hhx1TSGDpCRLbcCq4bE33OmNQqoBGKXs4xj38UZlf64FHnpXFR
         6K2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779127932; x=1779732732; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZHpu577JJ1NeIVxaJiVGE/6LzdYayI5qTGrF3i8FQs=;
        b=qwX7pkx8QlyU0XmYJ2urJtdjL6kZlPHs6u+YfxQ+nDXMC62kqisHo5X+7rjiaLZgwO
         8fNkQO9GjNvUgczIu2Dkse8CfBjwqgirFyo7vOln1SM/3qG7P9OUVT/SkE/pXkins2+I
         rg+oXJ8YLYl3qe2CbMLc1y1s9kMeC0JqxLwItG1a9ECpntPwkCfltiwLCsan0txnHh4y
         +zsPfwAhqkv5vAIsBaG/RGaBSu2Ade5pCly03P7fXb5LAlOUjpVlLYa52hB9dfXhmMtA
         Rh+imNU68DJVWYTu6GYW0mD3gBHGUelhh5XhSvUS3KYi0eC0nT4mRW1x2B4Z5DwGCI5z
         VWvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779127932; x=1779732732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KZHpu577JJ1NeIVxaJiVGE/6LzdYayI5qTGrF3i8FQs=;
        b=HYj7pOgwIFGOYt3OVa4TTQDrdCP6/0xSxU0qP7zBjH4GHM/C6fv0bnrtyDFZoAGkgX
         HRfthc3cDNtRPjqBQYlMp/SoLm/FExD8z9WEV+gjS+HkEO0yyNYmG216N8gTY04YGVWb
         rPQCz4lCJBY7PGLEGWdsZAmzWYe1PZzLo2eCaXDXXwx1HR8PPjz4vcfFik6EcMil1BAO
         uMiEbi/87XHGDHAEu+uLTE48awxcquVCadVT6O0nksOR3YB9t/v4yKYofKu4ncwL7nqg
         1ps9uslVj5tnNuoDPEvKJBhPZcrstDAkolL6lVxIyjWIASFl7rkWqlI9tfser6MnwmmH
         nIXw==
X-Forwarded-Encrypted: i=1; AFNElJ+qtPdCh9hlRkknrR8XyhVC+xNV6kxzf5O3MLslvN9B7zWt0eTJLVti7u6SwlTw3wyYSpXPRm3b@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7IGzMMIF0HoA/iv2vqiXxOE2oSmu8lmKFTZUd3wReD0kdL7ru
	YfcPgeHGfR/1bqR4f3ut2v9k7NaQNTXyVGptmN1GOdbj4y9/ST2ZBiSwCujA99m432zY97MOmsn
	C/aiygXDvGKyEzb6J0cSVzH3BjxCCdYw=
X-Gm-Gg: Acq92OEaD2XQgSZKEejnfSAMFCeWM71LkZZrvmAc+OMV50T8pHL1YHDlWJ4/EE8F4B+
	8VcELz3SJjQKJg6nmxZZzjIp23EC9dJLE8YQR+esSkB7/WYdnsZGM3xSwqWH0BNHaUjcSOxCpIx
	3xRCgtmIpn42N7R1ziI+KEZ2duGtkG01/gng719UrA9NShZ1l1mGg2aLAS50wLqvn8L1oAZHx/+
	VcCL3VbJi6v/0vcy5cLuqe/5oyRDXs+D7Dk8gXQyNW/3JhuD0PuwHZbaIocCyFWUR/U02j42Trr
	7hmJ/Id4Jv9fJQ93cHxByOmXmP7IoP4ODG+dpAUc
X-Received: by 2002:a17:907:3ea1:b0:bd4:8b66:334f with SMTP id
 a640c23a62f3a-bd517970cf2mr899520566b.33.1779127932053; Mon, 18 May 2026
 11:12:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260517-swap-table-p4-v5-0-88ae43e064c7@tencent.com>
In-Reply-To: <20260517-swap-table-p4-v5-0-88ae43e064c7@tencent.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 19 May 2026 02:11:35 +0800
X-Gm-Features: AVHnY4JLUOvMrdWhKo7VoEAUHwrjl00yvvDBzd0qqIXKzU2hB02sehpGkoppkGQ
Message-ID: <CAMgjq7DryNOmJbJ38tiwFadVT3oaMTTtQ3=BxD70s5AVjG8pbw@mail.gmail.com>
Subject: Re: [PATCH v5 00/12] mm, swap: swap table phase IV: unify allocation
 and reduce static metadata
To: kasong@tencent.com
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <baohua@kernel.org>, 
	Hugh Dickins <hughd@google.com>, Chris Li <chrisl@kernel.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <bhe@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Youngjun Park <youngjun.park@lge.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Lorenzo Stoakes <ljs@kernel.org>, Yosry Ahmed <yosry@kernel.org>, Qi Zheng <qi.zheng@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-16041-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,kernel.org,nvidia.com,linux.alibaba.com,google.com,huaweicloud.com,gmail.com,redhat.com,cmpxchg.org,lge.com,linux.dev,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryncsn@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,tencent.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: D77FF572289
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 17, 2026 at 11:40=E2=80=AFPM Kairui Song via B4 Relay
<devnull+kasong.tencent.com@kernel.org> wrote:
>
> From: Kairui Song <kasong@tencent.com>
>
> This series unifies the allocation and charging of anon and shmem swap
> in folios, provides better synchronization, consolidates the metadata
> management, hence dropping the static array and map, and improves the
> performance. The static metadata overhead is now close to zero, and
> workload performance is slightly improved.
>

Sashiko only gave a warning this time (and it's false positive):

> For devices using the swap cache, __swap_cache_add_check() enforces
> uniform zero flags. If the flags are mixed, it rejects the insertion with
> -EBUSY. Could the readahead and swapin fault paths then treat this as a
> transient race and unconditionally retry in an infinite loop, causing a
> kernel livelock?
> For devices that support synchronous IO and bypass the swap cache,
> swap_read_folio_zeromap() detects the mixed status, triggers a warning,
> and returns true without marking the folio uptodate. Would this cause
> do_swap_page() to abort with a SIGBUS?
> Should can_swapin_thp() retain a check to verify the uniformity of the
> zeromap status across the batch before allowing the swapin?

And no we don't need that, __swap_cache_add_check already unifed the
check. There is no device bypassing swap cache now.
swap_cache_alloc_folio now handles the fallback or returns the proper
error code.


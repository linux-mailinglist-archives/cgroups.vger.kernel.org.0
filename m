Return-Path: <cgroups+bounces-15727-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0BwEHticAWoHggEAu9opvQ
	(envelope-from <cgroups+bounces-15727-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 11:09:44 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B5750AA38
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 11:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C111C30E0DBD
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 09:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFF93D171D;
	Mon, 11 May 2026 08:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dUVfSzUB"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395253D093F
	for <cgroups@vger.kernel.org>; Mon, 11 May 2026 08:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778489889; cv=pass; b=EPiTaplBYDQggwVlX0tsPMgaddsCwV+zyVAy0q5l2DxtPMIx25dJ+Hk9Sl7T+jY6uU64Ttfbr8dF6XcsMwcL72ENA2NW2LttZaA5mbx8WAlRK3KUPxXpMgijLIRwjUOfaWyR90myVuXpBO31mB8TLzP8+nFkG/SW6aFCpORk5bI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778489889; c=relaxed/simple;
	bh=BM9h6f+Ityq4StWVleIqZYwKmfy1XjZkerlVyBBDiA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nVRYQxK5RXz9YDsQI09zmZwihfyf/GWjUfGmkXNKzvoBX4HRHM76am4yChYYdWG/Kn7vZOExYJyIjYt7ymsGaGxdP8IPqVRriWBqUOSDLSE4MWWYc2ol2mcrEqR4zbWfwJysBVIRnVXy2Rjc/8dFU2awOubYvwe75ryw2YBEQx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dUVfSzUB; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-67b6da5a618so5485463a12.2
        for <cgroups@vger.kernel.org>; Mon, 11 May 2026 01:58:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778489887; cv=none;
        d=google.com; s=arc-20240605;
        b=I0SemFbi23YsLEpjj2Y5ClpB5l/VIuvM+ueCwm3JhI4c5AI4ovyEeeoLjhENuk2dzT
         xYSeisi2GCo7pnK0JlgWYhcF7BEiDezvJQ0BAS0OIARzHaWUR7+6QpWSZA/d6RnsJV3M
         KDku7MnGAMXI5wogBvDpW2ThgSDn14VmT9V8KgKB3uzw92OJuBQjT1LpvNJAUc4dUFND
         JOeINZ81gOMyHqYnOil2WjHlY2Z9lnXFxQg1CyZljV/iSMou/n+fHT9HT8MrhNwzKEgG
         M/n4ht/oPgpUY07teJahK40I0GXtrpp3xm132yH6As/dGyLp59yKzw+R/QXUMP86PZua
         p7Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BM9h6f+Ityq4StWVleIqZYwKmfy1XjZkerlVyBBDiA4=;
        fh=5sE1+SxTD7qRp+2aC4KguJDAoSaU6kxJbMMGBLZvVNg=;
        b=lyoqa6E9XysgaBBjDJ3AOKbaXGCZCx2LIoo35tPUToCF6pNEog+KYTFFSM7FzAogGl
         uyoQUaFtxOG3fGAybAat/c4BEShsXlB7z0NxcsHTtiiZCsqmXT3NZO1OiiQQ5plMIKrq
         oyihZlFteJhTafDJkD8yGLtVt7YQ9KfRJ4gINQRE2JI3tVQzInTz6i+XTsrSCy79sjU+
         vWLX4fT5Hy9via78oKV1XUbQOLnt11faFUorZwAiqmYtfvusbugNNJc9SOqJ0jxkI5ND
         abJkNOAGK+fnEN5nxA9HYWWZ3LyXYBsI1vENFQ0O0gMlvoUREeXyzHruSbiRB6nopUvp
         +mag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778489887; x=1779094687; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BM9h6f+Ityq4StWVleIqZYwKmfy1XjZkerlVyBBDiA4=;
        b=dUVfSzUBvDQQJ9jilWiKIY5+R4SVOQLeGBlH/YqXiSb5N9XC/Bkt9XhNfMtZi49ZFi
         ByTzexnIpB0a9O4qKoJGsHEDZjOkivs+DiY0tlfW1CoUmYwAY78bEX5xpeqlHT7iIc+O
         rH2wmi7k9Y9ReqBGPzOWx8xiVIXjfc3gQatRmxdKzMTUdf7jvHvU8qGQMd0aGJyB8Qim
         4K1GLC4sGmcfgRD/m4PtaR2yl1xrvbGMxm/PaYwouifxzGs0Bm3BpTdB9jxIGYLKi1JX
         FXP4q0P3hkA6CV1Wsm5D64QSv8SOAsAWrnRHjLK8YCe3AdQKHuNolnhYwr231NUIsqnd
         qY+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778489887; x=1779094687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BM9h6f+Ityq4StWVleIqZYwKmfy1XjZkerlVyBBDiA4=;
        b=IOyap2ViG6bxFI3P7Hr9J9KqMwptoBOW9+UFk0fSVCduW9eS4J2hxlrN4sdM9rwI2X
         EFZLW+WElQoH1nXOmW7ibpzLa1UELQj0FIadqpVHJlO523hq/Jst5P7oFqn3WxG/Im7p
         04oaQJYUv4dkRtgm0dDF/ZhqI3Eh4E/Qs3ujynK1j1khNaZY5gF9E8umnLBsLtsebuxA
         yTp70rlZNtjTg3EWRO05ArWOgGHOP6y38QbaKq9ZBGqOvmBSNueTVSi1iFxi4aZqn3B/
         r8+XDJ+pH1KLJRwp1Ps2uf68pE8YPfZoKwcbRlGCwf+tnxMkWfERuQdawaALr8x0EQyH
         GGxg==
X-Forwarded-Encrypted: i=1; AFNElJ/VrSVvArbR7DR1e3kmc7oYhQgsHCWdiQT1+scJbXa/Pu985enhAKOIpcbb5n6DGm7AfMt6RVhM@vger.kernel.org
X-Gm-Message-State: AOJu0YxERXLiftS1muukiCdm0FOH36eput3j6hD4sK5p+bYZoBTDMbWv
	O7IzQhDeiDaRc/JCqUbvzjIKqxAcBkdCob83rlB00yYNmgLkrhzOiavK9L9tsHdnyecLi0oQ7c/
	xQLEXl/BpxCe6Js9niP66Eta/j/xtkMg=
X-Gm-Gg: Acq92OHZRToBQk2YAEJ59CLorUYa8vetIVi/cG824d1wUGum0idMGfC6RDKzXyW/KS2
	8zdTB5wM2aRMCsKha3qYzNiVeSSbAvmSPq+k+zf6kQFTIBrPr/rbt74hnW+pgiibYufz/1hahz7
	BO6Qf35QqmFZlia//2Cl/Gd7iAC3vPliIGLTdAshftLHK1qmWm0rToKJYNN1AW3cW4IxFWpI89L
	xhfLzs3OZmW1cS3HkC8M4h2iB4kY27O3eMSiBXRz4RWoWx7tvGJPIKwqasFVmoyu+AlpPlBQs2L
	0xth2p1kjsfmYVQr2tPc9BfZt/Ja0L0w4urVSrbN
X-Received: by 2002:a05:6402:21c1:b0:67d:a61:52c2 with SMTP id
 4fb4d7f45d1cf-67f713ce119mr3186213a12.23.1778489886407; Mon, 11 May 2026
 01:58:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421-swap-table-p4-v3-0-2f23759a76bc@tencent.com>
 <20260421-swap-table-p4-v3-1-2f23759a76bc@tencent.com> <CACePvbVNwaU=609oJmAwqxse4WTApj30rU9hB_ym=FLjKMk2PA@mail.gmail.com>
In-Reply-To: <CACePvbVNwaU=609oJmAwqxse4WTApj30rU9hB_ym=FLjKMk2PA@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Mon, 11 May 2026 16:57:29 +0800
X-Gm-Features: AVHnY4I31doUQo5aj04iakMn-BxF1hUQL6KJfcIRhBpM0p1ftOZPtkKUBT1lgeY
Message-ID: <CAMgjq7CRRxXdjjMCuzWRRgEOgh9rSz9j3o4aR5xfLRRq_7ELDg@mail.gmail.com>
Subject: Re: [PATCH v3 01/12] mm, swap: simplify swap cache allocation helper
To: Chris Li <chrisl@kernel.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <baohua@kernel.org>, 
	Hugh Dickins <hughd@google.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Youngjun Park <youngjun.park@lge.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, Dev Jain <dev.jain@arm.com>, 
	Lance Yang <lance.yang@linux.dev>, Michal Hocko <mhocko@suse.com>, Michal Hocko <mhocko@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Axel Rasmussen <axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: D4B5750AA38
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15727-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,kernel.org,nvidia.com,linux.alibaba.com,google.com,huaweicloud.com,gmail.com,redhat.com,cmpxchg.org,lge.com,linux.dev,bytedance.com,vger.kernel.org,arm.com,suse.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryncsn@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,kerel.org:email,tencent.com:email]
X-Rspamd-Action: no action

On Wed, May 6, 2026 at 9:51=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote:
>
> On Tue, Apr 21, 2026 at 8:16=E2=80=AFAM Kairui Song via B4 Relay
> <devnull+kasong.tencent.com@kernel.org> wrote:
> >
> > From: Kairui Song <kasong@tencent.com>
> >
> > Instead of trying to return the existing folio if the entry is already
> > cached, simply return an error code if the allocation fails and drop th=
e
>
> Nitpick: Spell out which function changes the return type here. It is
> __swap_cache_prepare_and_add()

Good idea.

>
> > output argument. And introduce proper wrappers that handle the
>
> Nitpick: Spell out the helper function. It is swap_cache_read_folio().
> > allocation failure in different ways.
>
> >
> > For async swapin and readahead, the caller only wants to ensure that a
> > swap-in read is issued when the allocation succeeded. And for zswap swa=
p
> > out, the caller will abort if the allocation failed because the entry i=
s
> > gone or cached already.
>
> Should you add no functional change expected?

Yes indeed, there is no functional change.

>
> >
> > Signed-off-by: Kairui Song <kasong@tencent.com>
>
> Very nice clean ups. I like it. Here are some nitpicks; feel free to
> ignore them.
>
> Acked-by: Chris Li <chrisl@kerel.org>

Thanks.

>
> Nitpick: IS_ERR() only checks that the pointer is in the error code
> range. If the pointer is -EEXIST, it will always be in the error code
> range. I think the "IS_ERR(folio)" test can be dropped.

Agreed. Actually, I didn't add IS_ERR in V1 then Sashiko complained
that it should be added. I just checked the API documentation again
and existing patterns, there is indeed no rule to prohibit the direct
check. Let me drop it, I also like it better that way, and maybe just
ignore Sashiko next time.


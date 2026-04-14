Return-Path: <cgroups+bounces-15297-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEwjGkp63mkHEwAAu9opvQ
	(envelope-from <cgroups+bounces-15297-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 14 Apr 2026 19:32:58 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CE44A3FD1AA
	for <lists+cgroups@lfdr.de>; Tue, 14 Apr 2026 19:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B42A53040C4F
	for <lists+cgroups@lfdr.de>; Tue, 14 Apr 2026 17:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4DA3F0752;
	Tue, 14 Apr 2026 17:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZX10aqTN"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7240150997
	for <cgroups@vger.kernel.org>; Tue, 14 Apr 2026 17:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776187976; cv=pass; b=WBp4ZnwgIXRzJFtUs3QOg4sSDw+GqcwWq9d4MFk9HguFTMNqyyIQF6oygq/nqH4Fis1+tpkhjp9FvPOHkbTtvGowtAwSetw4cTnWjjwxSF7/TxzALXEC/LXrpumZRalzgKulFRrxCXPsYt7OgUFrh6UIeEVv6/TeiPHPpmpk30Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776187976; c=relaxed/simple;
	bh=c8VROB7nPEHNUyRB5MclbcMkN39zlz8ADjK6buJJwrg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EoY+ch8S4IAz0Vi6td98u5eQ2ohQcqUsa9vrv5LI7L6MWWGr6iU+EXFzo1F7Zqbywv2vUiOW9ervoY31VJ5YN1OZRwTORYrX4aAXdg8gDOgN5+j2iY0F2/3aAbitfa936vqZ44wTXr6GStUcMqmLxgUR0CfyMZH8o4W3I2vqhHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZX10aqTN; arc=pass smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488b00ed86fso60917595e9.3
        for <cgroups@vger.kernel.org>; Tue, 14 Apr 2026 10:32:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776187973; cv=none;
        d=google.com; s=arc-20240605;
        b=V+wYYB61aEHMp6X8mVwdZbRsSut3wqhWeUwfBkp455ZDLbk3j5RgWzLERfbHd1lmYH
         EA/ryy4gB2beQjoSJ7o36nwnT8SjcfJaWMjY3BcbmJ1sEE80ZNo6W1fduSxeTtRMfrcl
         uyb4aB6gHbbVXsxpE2tcGARqpwx70apFzMrHXaOHJWlOj4zWmlolLeSLYkA6RhfSZyDv
         4lYVc0rfucNf/j1GS97d9wuzoPgrNBmm7Xwpu938NTWcOu9C5VMPvJPFVva7MyDNzRpO
         RxnU5CUSl8icQxlLKGv8xqpjil5jXae256dPEY1st5zywdouzntlaV5mgmTAg5nIpdsp
         yMSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c8VROB7nPEHNUyRB5MclbcMkN39zlz8ADjK6buJJwrg=;
        fh=sBgo/eZB38z4vt21ymU31R2cH1bCbxVJnKBa8wEeLZM=;
        b=hLnfnN+Te6TrYjI2x8BfZ6rCgDkZ7mNj0XXnFDce+HbOgOjjJc0uxPbdJ9y4zRgYtw
         Ce58K67PQDH0uhRSK52vyhIvAGauw3OX2x+8kNrAd4KXG8hf+ztxZ2p5m4G6QSN9Ko4n
         ViG2fGQF2hxfeKng3piO1nSoY6XU5tiqPxD/ENg5M+0ceBhwLTd2hGyS8An5ZFssSDBr
         BqnOsY5o7iMwbZ4SGUeRlfNHSbbWugUdo3WMggx26KJcEr3Rxcqrxl9ULNoDwx4L7r2V
         mYrhR03TIlkYGlzNEKV476Hu9Y/dJlPbV+jVc+0NwicwnB2UNEj5eOS4t4s1k6ublQvJ
         9LxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776187973; x=1776792773; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c8VROB7nPEHNUyRB5MclbcMkN39zlz8ADjK6buJJwrg=;
        b=ZX10aqTN6ueyUDSbjhQxBmYCk+6Qh4RbTFKz6qsoVLZ8XXsN0jMCDoVnjk71jKY2is
         GKgIWSzeaYIPOPqiw8qIfwjP7sVd9qedkfhH5Mva6wk5h7nNaNywd1n3HqEsv34tqhoH
         I8hwJhRvdVYtqNpl/gR1ddpVQqOCtsgP0183AFph3MBF4afg+LoFr3ZpSX5DLKimtoyF
         mCEtFU+t8IDjK7In/U7uTxNDiIndapshHTqfCe/dn+zyWu4veJEXYT0Yu2MQK90BeV3b
         IDhR902SJ6cgHedCu4VOcexxfkw0KCXyYs0CfxieXZxftaZiOjUomdtveXRhB9JgTMT0
         DiIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776187973; x=1776792773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c8VROB7nPEHNUyRB5MclbcMkN39zlz8ADjK6buJJwrg=;
        b=sz/xWzeZvV03TfzzMO38nZN33FEn2/aFIzmTrEvNC5RpEqt8ltzKCnnVQN2Rh6p29M
         WYaJ1pxlzdhCBLxMuN9M0wFyIMyXlyUuwHlsKcJ7Dsi0sFYqanPRSl2vOHvuHaGAoiWu
         035vUPqkgilXWZJdziS6PlxHSQbihtP0qLDjRKFh5OJAsUjYAFY7vDL/aoaJ0ls+CyLs
         mDV/U6Oxqos19qI2bOggd0tOOB5gQtdg5930mvOn2wWUuRaIzMRDLcbaIx4zuFDLkvhh
         8gf79JOU92wymS3xjcpjgFKdXhHoDErz7GNSmVwCVyWxPBN8KxCswxAAnMKs0jFSiswM
         8XqQ==
X-Forwarded-Encrypted: i=1; AFNElJ+jWTvGoYo2QTZtCwKw2hknW+N324zOL2ziWD+KwvHvhZRB/joKgpj5+eMmHYoLAs8SgZ04o5/p@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3i/rOww+K5y8II4j5T7b25WfNF7rHz4qKq0tu6BB2CcsTIkxD
	OvYiBTcE5/pcHvNGLND/nncZNIs4CQjsadZ48BWBN9L6r/HwQamYtrpQlIPBNyIXEddnb5X9xyT
	cmTM7+6Xk4u1HKEm1mtnAzWvG+4u9hDE=
X-Gm-Gg: AeBDieuuxp/tkygrUn0d+BPbmCIFP/71OJQ+WxcIwI6I7lgALx48VYEiUkFqSMojncY
	7y+wRF7FT6huJ6/YUjAqnP8NOrDgoMuN0/f8vI92Pm3onWgi2CwzcOrd5Ua2YBnihA4W1qOIEpc
	F9QdSBIYz3YmqyGBP5f6l/RnAszwyint1juY8jG8uC7AA5NDxm2qOpzNOE9tc+92aRQ/AX9o935
	i/jvREZXicDAWVuH6Esz4Sib4sTNvwwgNqg8yH+mC7pb1VHG4Oo71U7eLfkVfNMefpRlkTHwY4G
	WnZzhtXk5aVoF9rODKO5aJAJ7LhtqcEVkn1x+VM=
X-Received: by 2002:a05:6000:1ac5:b0:43b:3d02:7806 with SMTP id
 ffacd0b85a97d-43d642c852cmr27633427f8f.28.1776187972920; Tue, 14 Apr 2026
 10:32:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320192735.748051-1-nphamcs@gmail.com> <CAMgjq7AiUr_Ntj51qoqvV+=XbEATjr7S4MH+rgD32T5pHfF7mg@mail.gmail.com>
 <CAKEwX=PBjMVfMvKkNfqbgiw7o10NFyZBSB62ODzsqogv-WDYKQ@mail.gmail.com>
 <CAMgjq7AzySv801qDxfc8mEkEsFDv4P=_qw0rNOTe0n+qy7Fz6A@mail.gmail.com>
 <CAKEwX=P4syV38jAVCWq198r2OHXXc=xA-fx1dk6+qYef6yzxWQ@mail.gmail.com> <CAKEwX=NrUhUrAFx+8BYJEfaVKpCm-H9JhBzYSrqOQb-NW7QRug@mail.gmail.com>
In-Reply-To: <CAKEwX=NrUhUrAFx+8BYJEfaVKpCm-H9JhBzYSrqOQb-NW7QRug@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 14 Apr 2026 10:32:40 -0700
X-Gm-Features: AQROBzCXAeCqcScOKrvPHFEfL-AEpSgsJNqZGDJveRabXpX0aHvntrnXQgowKrw
Message-ID: <CAKEwX=O4VJzHGqJFnXOyUhamr5-hckrd+C=V8+f-Lz_HNtaJ_A@mail.gmail.com>
Subject: Re: [PATCH v5 00/21] Virtual Swap Space
To: Kairui Song <ryncsn@gmail.com>
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, apopple@nvidia.com, 
	axelrasmussen@google.com, baohua@kernel.org, baolin.wang@linux.alibaba.com, 
	bhe@redhat.com, byungchul@sk.com, cgroups@vger.kernel.org, 
	chengming.zhou@linux.dev, chrisl@kernel.org, corbet@lwn.net, david@kernel.org, 
	dev.jain@arm.com, gourry@gourry.net, hannes@cmpxchg.org, hughd@google.com, 
	jannh@google.com, joshua.hahnjy@gmail.com, lance.yang@linux.dev, 
	lenb@kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-pm@vger.kernel.org, lorenzo.stoakes@oracle.com, 
	matthew.brost@intel.com, mhocko@suse.com, muchun.song@linux.dev, 
	npache@redhat.com, pavel@kernel.org, peterx@redhat.com, peterz@infradead.org, 
	pfalcato@suse.de, rafael@kernel.org, rakie.kim@sk.com, 
	roman.gushchin@linux.dev, rppt@kernel.org, ryan.roberts@arm.com, 
	shakeel.butt@linux.dev, shikemeng@huaweicloud.com, surenb@google.com, 
	tglx@kernel.org, vbabka@suse.cz, weixugc@google.com, 
	ying.huang@linux.alibaba.com, yosry.ahmed@linux.dev, yuanchu@google.com, 
	zhengqi.arch@bytedance.com, ziy@nvidia.com, kernel-team@meta.com, 
	riel@surriel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15297-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,linux-foundation.org,nvidia.com,google.com,kernel.org,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,gourry.net,cmpxchg.org,gmail.com,kvack.org,intel.com,suse.com,infradead.org,suse.de,huaweicloud.com,suse.cz,bytedance.com,meta.com,surriel.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_GT_50(0.00)[53];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CE44A3FD1AA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026 at 10:23=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrot=
e:
>
> * I still think there's a good chance we can *significantly* close the
> gap overall between a design with virtual swap and a design without.
> It's a bit premature to commit to a vswap-optional route (which to be
> completely honest I'm still not confident is possible to satisfy all
> of our requirements).

And to further note - these benchmark measure, in effect, purely swap
overhead. In a production environment with a lot of non-swap work, as
long as the gap is close enough I think we would be fine, even for a
hostile case like a fast swapfile-backend (I assume SSD swap's
bottleneck will be the IO mostly).

I will stare at your responses to see if there is other benchmark I
can play with, but it would be very helpful if you can share your full
suite :)


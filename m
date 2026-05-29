Return-Path: <cgroups+bounces-16440-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDLxM1GrGWpEyQgAu9opvQ
	(envelope-from <cgroups+bounces-16440-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 17:05:53 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A07060439D
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 17:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21D50303788B
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 14:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5052429838;
	Fri, 29 May 2026 14:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CkndXglT"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413A63F44CB
	for <cgroups@vger.kernel.org>; Fri, 29 May 2026 14:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780065971; cv=pass; b=ShtVnUYiRpIZV79JoEpCUP6zffjQH7DcZ4tOCpowsu2TNU+viaOgJvr3D97AxifirY9K+Z48XHBB6JRfyvecigz8OuKQixy2noFP8QItnaMD1W9exurpCJJ0pUplumuld7kjUK1wPKY5GJQ7dqaGmg6RE184KAiHSBC++mnC48M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780065971; c=relaxed/simple;
	bh=G6iX20sxRFgzRU/6WWLyIcEgqd92EjfEQ5ikoGiyUDs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KnZEC3OIv77qC9p4gVJvZLWuhaadS7uiiMTUM2TSKHjr3DkzA6yzyQ/DKlzkXOTYYWLJwT+Ftik7G/4LJodcJJ5fXnxrF9ALfHQ2xCUhXlWfyuM0dAjfA6dEmIhMDQ1RMIeULGyk7Er1AwuraSHYX+HCO3b8O1/qR21KMGe5jcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CkndXglT; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-68bd167797dso1442566a12.0
        for <cgroups@vger.kernel.org>; Fri, 29 May 2026 07:46:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780065969; cv=none;
        d=google.com; s=arc-20240605;
        b=WxdhCvP8hgfZ7zE5DfiG1fTx1AQEjkV82zaD59NQ+pssPutwCbl+eW6wzHdJSOKsUS
         Y+omhN87ChwXlXrAw9TXHFzVXKQcv12VFjK+ujd4iIMx9bjxBSKYeHGNuGfjs594bFA6
         pad91W9ANGUdVhYCWKmrajxSM/J3Jf/4D0Q9fd7An4ydxZjv4HyHEFqC8aWCKc1RgvO6
         prG3Kg/GatniPCRwAyb7J/xQMN8OTW8HP+J/89M8YXDVC1BUci2mff3kAyubal+EerOK
         jC04EJYl5RtPcOCwSY//w/7Qou4XRCbxkLKiFBoPDOvy+RkTab5mkUgQ0ZlwkwIoPaN4
         sYxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=G6iX20sxRFgzRU/6WWLyIcEgqd92EjfEQ5ikoGiyUDs=;
        fh=jpvhiBHmBpyGjkP8kKZ/mZ50pvtyIXZs4Sx34nT9lGU=;
        b=F2NYAu1bAJkPs5YoJGr25G0/eTEybup4cB1v7wOpeHgTAbwjFxwHi61REVTRNsrA0/
         eYo6K8nRZlPXqIOi+FezlCzWqK3+LMWP+5q0lmER15W3acXkzbU4foh+hYkoJV33Oejt
         hVz30yvTMFFV3aw34f89ZEZyWalzilNeIPjq0Y6kV9jeqz3H+uPs5B+DzxVuZPzQhbU+
         vIdLd9tY9EPeVanY+MH8QBs6J5w1nHKErtY2aHByvyiWjYWBlB3C1Os/vLgP1iwM0utz
         HLwBdzWnI1GvAcEt/KmGX74P0zDHAnFMRZvUXjoLV0LkmvWwkhns5sInYSMHNfgDovR5
         X9kA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780065969; x=1780670769; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G6iX20sxRFgzRU/6WWLyIcEgqd92EjfEQ5ikoGiyUDs=;
        b=CkndXglT+eSSnbITQEhmgJyaauQ93qqF3yB8cZ+fjGAo6/hF3Fj2JhfLQN3ApFrx0F
         rBSEKrhOHgBpfQUUgqQ703pyVFJtLyyu+95JHA/k4dObCPkvh3wfRzJTqAZeNHsZU/MQ
         bbqHxDkBAuVNc4cxSjlaX/UqC9fEvl96jMpq1Met6eQD+InHbnx85j8UttcDQA6u4jB2
         ALTdlL6olUnCVplQbVqcIZYbNTuUNk03gDeEa5o4ooScqs30vfGGrDBAlrF8VC4klOV1
         eo1vGtZbTCt6MSst2V8iKWQPy3blXTPkj1lnNpAEDIDWmKgC7FXKmWXTea5nZMhrbTQy
         GyIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780065969; x=1780670769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G6iX20sxRFgzRU/6WWLyIcEgqd92EjfEQ5ikoGiyUDs=;
        b=k3XrpvMukH0TeuKpcZlPdLqOdCGvrW4mw9iWdrGTdb1qEQTM/+mj1gRHeIhBhdR01F
         jpc8uV1Pa1uj9F9R0MedyeEn1JZG8yRjNgRajUajlHMNqv7evGizNJSgR1vzEXXoZPEH
         2Vx475SwsD/DN9AhLzYNR4vbvC+eAMq21musDGsy3ELr/GEf+OnQgrMVR19stsJxw+Lw
         a7gCeZON4zw8cIGGIbYSTGPngbt0PVUsjRbYCfce4OcCDyvokfymVyG/XS8d287jsaU9
         UzHrquPyTxtJl+yasM0TgvJ8x4505uhXPTTUYlybwoe8km7+KGTplHr111y9YPvRG/Sn
         0AHQ==
X-Forwarded-Encrypted: i=1; AFNElJ9fttklX21IpNAOeWhWszxjB49w6kBxvKBcpaK0h4VJyY5bcaRzY6aAY3R1vcVxjOhCfruvxg3n@vger.kernel.org
X-Gm-Message-State: AOJu0YwkgVfkegI5TiaVb+vlADk1oSWTCDi0vGb/UosgJGsszgM/xwwY
	RdTDNrk9aBo0g9rjxvAapZooF/ULvxSrwhSWNhL/U5XrGEDzZnBuARDhyE5Ld2Z3YEX3cDeE5B7
	AadSRdhEerr7xs6EHFGbpPMfiEWG/C8s=
X-Gm-Gg: Acq92OHFDviWo9aPTh/Vuqu0iy1Dq3Zwu3r4kOox3c4dNr9+gZwqrNgRyCpRzwQyMyh
	ORy9RQ4uq+ahNa8hM8Mw1TvKc1pQEtcMhrg0pcblBiJZeHM6VPHtHj0r2jJ/DxNEVrQChLpRGab
	GRau7NzTv2VDv4uSJYvguwhyFNGapArVC6IjdLdcY+GhWYDlfChSNpvfJWasb8RHOB1wsrQbfJr
	sIuCSinrJ7GKildLSJ7Y32v5QF5BIzS31yu2jfCwDp1K8o+eulsh1NF0EEWt4Ve4K+iMXmIOlaG
	5RcO2AdVwzOQQTJ8OgRYGhvJxWjHyPDc/LX9NAUwh5tRk9zsvpY=
X-Received: by 2002:a17:907:2675:b0:bd1:4da0:b0d3 with SMTP id
 a640c23a62f3a-be9cac109d5mr144354666b.9.1780065968066; Fri, 29 May 2026
 07:46:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_98CD9F78E48D08DC005A6471A13CFF28B60A@qq.com>
 <tencent_EB78848E34DC7858C873193D67286ECD4B0A@qq.com> <CAMgjq7AA_1esgtA8VyxaBLWBBRM12bCBpxO2Jch5OESBZSg--A@mail.gmail.com>
In-Reply-To: <CAMgjq7AA_1esgtA8VyxaBLWBBRM12bCBpxO2Jch5OESBZSg--A@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Fri, 29 May 2026 22:45:31 +0800
X-Gm-Features: AVHnY4K86HI17pY8YJEJfJmy5evEk78o1qo-0ZFpkl9b6nLVN3I00fORb5XL1GM
Message-ID: <CAMgjq7AQwF6oNpnGTxxJWb=oyZ3dLfPL4oSNoS+eQxtuzZPgTQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/9] mm: admit large swapin by backend range in swapin_sync()
To: fujunjie <fujunjie1@qq.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	Alexandre Ghiti <alexghiti@meta.com>, Usama Arif <usamaarif642@gmail.com>, 
	Chris Li <chrisl@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosry@kernel.org>, 
	Nhat Pham <nphamcs@gmail.com>, David Hildenbrand <david@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16440-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[qq.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[linux-foundation.org,kvack.org,meta.com,gmail.com,kernel.org,cmpxchg.org,google.com,linux.dev,vger.kernel.org];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 5A07060439D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 29, 2026 at 10:43=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wro=
te:
>
> Hi Fujunjie,
>
> Thanks for the update, but this whole defer_memcg1_swapin thing is so
> ugly I don't think this is the right way at all.
>
> If you really need this, maybe you can always defer the memcg1

Oh and I'm not saying I'm against this series or the idea, I'm just
saying this particular design of this one patch needs some improvement
:)


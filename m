Return-Path: <cgroups+bounces-16921-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id J5oTJmFWL2qG+gQAu9opvQ
	(envelope-from <cgroups+bounces-16921-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 03:33:21 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E1250682C33
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 03:33:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=RKVrG6x2;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16921-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-16921-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 805543004F6E
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 01:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5701F3BA2;
	Mon, 15 Jun 2026 01:33:17 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2647E1D6DA9
	for <cgroups@vger.kernel.org>; Mon, 15 Jun 2026 01:33:15 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781487197; cv=pass; b=LJS4NwKFBP/dzt5kK6XF7U06LFRikkfo3lTzea1Vy+xivriy0RPKtRTkO8h2GHEeWXNFlxCon5QklE0QN16Mw4uySlIpKEjkcWTce1r2BhGElb44ALqm+NVLGs9ARLXRXBa0L1szyUiDVHBBVQM9LwWh/ChvwcrME6WicHLQQkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781487197; c=relaxed/simple;
	bh=J20Mk9IIIo2zN9ma/BgTDf53PLctgl/qN6NJYul4qHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ac82bJKkSx72M5BD0cygZhshl8UFgIS1tXwlKjaWIjz9FFC8sAgBq9/5EnWaRmJGvQzuXmVDTatqPsA0poEPi7QHlS4TQq3XCcQUzg2B8+IlvzmmoFBN+Khl2eellaBI/81rIKOdqRrZwUjGpGC2bjC36TXjDqaFpgdOyASLW74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RKVrG6x2; arc=pass smtp.client-ip=209.85.160.182
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5177d1ff061so659061cf.1
        for <cgroups@vger.kernel.org>; Sun, 14 Jun 2026 18:33:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781487195; cv=none;
        d=google.com; s=arc-20240605;
        b=DyLFeaiYPjUFgqHpyPSTMv6HJVqpyeC/Z8LTgflb2KdnRDbV+J3FZcP7+xhiRAHHnM
         wmIStrQ/YEndoj1UQeihfWC6bbTJOjK4ZDm8TF34Jc/LgjKsbxYU5gDlVK0vthGUfpUc
         b8GljM2TqXwimBTy9z/O0wNV98Bb7Q2RlmdCa1KVtGWmPmmcIv3at9fiZCYTN3pkj2vO
         w7zoDs3thBzzQsDm4C6JY2Jlf3vpB5SsKMWfjfc4X8qEnwhOjFGs2MHkRXqt/nAXCrsp
         WD4wH1ufPG2dc6t59ycqf70c06cnUTUN5SuiEm1iuNn8Lt2INADaBOx0Qk+feHRZHYd3
         PDWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7YfAIRPnSgVTVTSZup2KxqvQOtyczG2cRa3xPgGvnEo=;
        fh=sJAvRB9ooWhaf3pNKzbdiSDxIfaDGoGeMEis94FFa8o=;
        b=AK4oEBkMT5RmSPXBKA+OL5qnEn1tu/We3T8HnRtdXHGW7HqOm5NKkOHnwgrjwftCcj
         WEHDCQS9t1pJ5y8KAS8nclhvgOLO5qft8ZcoNwzsRiMRoBcAWQBpYYRLI7n6pq4MbZr2
         NIZ+Vl26sFa1gL3FE2e+n7riyYf8wvsIJ1DebPGyjjVKT2j89DribtogoZsecn7gEwJg
         aGoEHI1KX88usLcfpeZvxC2oAM7WUeap68p0T1SaH6dska27m6IrJXiyG0Dork8Xc614
         BV5NENykHKnMZpE5E3hZDPvVGs4hGl8vqUITIxPyCHhpNobvA54MQp5pWPk9DAuluJnd
         uo2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781487195; x=1782091995; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7YfAIRPnSgVTVTSZup2KxqvQOtyczG2cRa3xPgGvnEo=;
        b=RKVrG6x2WRq775x0B9iWvwd4CScWAT4wbxjr9ftM6qjOv3HkDCmBwyrIZ7S21pS8cI
         5xTGNbwjF4koZE14mNFuq9I4W4PfvKQ7W/tAn3wbS82x/07wrtzdQnA+7J1IhKXyNB+0
         ZHYqYA2k3zjQNuvQJ29Q+NGH0W0yoRVP9zdtVU9WMPX3RnJXdw/KV040eGi3dZs1lsxh
         rSKboLz5TwH1jR+u2YTf/vQyLIom1uyf8oamvd8y1hczIBN9XVI+utAfU+VH0OLmUHev
         OJmTgwMsChLULbO9mEbQgCz8Sfqmct/xhf/Jy4E9gLhicnGClCx5jBQXKBMKCTFxFwk5
         X5XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781487195; x=1782091995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7YfAIRPnSgVTVTSZup2KxqvQOtyczG2cRa3xPgGvnEo=;
        b=ZdxBtyhKp4Xqm5nIiVTISNklki8G6M6qodD7x8r38cklMFoixmV0a5sTATN4ydp6YN
         JyehgNWXE7REzSiGKRL5sR3TXCn+tGgFjWb8Z0bzbwQDDbKN3yNbb5f4SgFJVnjTQRc7
         +QQrcryDyXDK1Qpl04hswy/IkWdlBmodiNIHKsKlHPnOHETJa1v/04EoyImUg2To+qZI
         jd7hX5Ga415ynf3BV9sCZPgBRADTBwcnm53GvtMbzf2EDdODgDscQdoKg9gGX11468Qv
         ldxze7F/iRweqL3Xu53kY1B/KW+LTrgCaQfqtk1V24dr+qRX/goajZhHghl5W9Vlsl9r
         zvLg==
X-Forwarded-Encrypted: i=1; AFNElJ8xM6kAbCXv9Yg7jI+4sNcvYRIEcB67pkRsMNgwTF+HV2dZ2EPgX/zCE+lNymNsDbvT9jNMl56B@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq69KlDHp+VPgsmKg4CyxnQoL9X2GHSDmO/1yX7joeITeAHPmq
	SlBlyip0IG0dd3meStqUl6WPchpNsy7rD5fscVbTsU2RvtO5hdhGjlSst6iFaTLc36InpoOscjG
	P4WQgmoO/1ZJUxYujEabdKF6kQe0x1RXOQIzw/UXr
X-Gm-Gg: Acq92OGQrhWuj7vbFMuJIrw5n8gS0Pu5C8QsdY6B9DxRoSzVVm4Iat4TFdGGMaenLFk
	knpUj2PunHU7pT4zKlGaHu1/4gnC1RqlkfPglR8kQXAhsYkV/ZXK3+GEyPK2ihS/SXORhd/A+s6
	KTs9tBVXACPBBOYJ/1aCSCpJ0MDrq3hQ/x+59qRTFr+dxJD3SnEZ2AfykqmeiSbwuBQkC17Nl0/
	CclozwgCbTeuBT1n28+gfxBK6Ya4fj1EvIf5uYOjHuaEL8U/ySo5N5GVQ69FSdxgrYn+m8WdhD5
	mFDqClT8Rt+kfmg8
X-Received: by 2002:a05:622a:4c05:b0:517:99ea:ab77 with SMTP id
 d75a77b69052e-51955ed47abmr10839081cf.23.1781487194598; Sun, 14 Jun 2026
 18:33:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610-slab_alloc_flags-v2-0-7190909db118@kernel.org>
 <20260610-slab_alloc_flags-v2-3-7190909db118@kernel.org> <aiuBW_xY6x5IBQfE@fedora>
In-Reply-To: <aiuBW_xY6x5IBQfE@fedora>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 14 Jun 2026 18:33:03 -0700
X-Gm-Features: AVVi8CdgiUpri-ysDlsl1zKbLaoB6SytnWZ1DdXfEBNz5uTw-d7A6qLAoBejAcU
Message-ID: <CAJuCfpHh+DW_G8VrD7yX9mU-onGBtkNecCmGJOgMoBqTm1GQPg@mail.gmail.com>
Subject: Re: [PATCH v2 03/16] mm/slab: stop inlining __slab_alloc_node()
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
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
	TAGGED_FROM(0.00)[bounces-16921-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,linux.dev:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E1250682C33

On Thu, Jun 11, 2026 at 8:48=E2=80=AFPM Hao Li <hao.li@linux.dev> wrote:
>
> On Wed, Jun 10, 2026 at 05:40:05PM +0200, Vlastimil Babka (SUSE) wrote:
> > With sheaves, this is no longer part of the allocation fastpath.  For
> > the same reason, also mark the call to it from slab_alloc_node() as
> > unlikely().
> >
> > Reviewed-by: Harry Yoo (Oracle) <harry@kernel.org>
> > Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> > ---
>
> Reviewed-by: Hao Li <hao.li@linux.dev>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>


>
> --
> Thanks,
> Hao


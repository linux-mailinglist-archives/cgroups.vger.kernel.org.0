Return-Path: <cgroups+bounces-14006-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 9zFTDekPlmk8ZgIAu9opvQ
	(envelope-from <cgroups+bounces-14006-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 18 Feb 2026 20:15:53 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC66158F68
	for <lists+cgroups@lfdr.de>; Wed, 18 Feb 2026 20:15:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 849E0301DBB1
	for <lists+cgroups@lfdr.de>; Wed, 18 Feb 2026 19:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6CC346FB8;
	Wed, 18 Feb 2026 19:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k0ibvlJR"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2DC319873
	for <cgroups@vger.kernel.org>; Wed, 18 Feb 2026 19:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771442145; cv=pass; b=UtjpACGd5ouJnoCPc7PbtTIw35rrAzK8w9l/5u4S1Ptu5R/08YMqRihfo9Hc5bdIn0YBy6Js+hbpUS9bnbnmsIPKWlIyDC0pQW7QhqPj0T5TKnNLEF3yBSWIyKS1jTN2yuCFlIvct3D+u2CW6c52ponk4kZzaWzs5u7+w49mhsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771442145; c=relaxed/simple;
	bh=wBFNCt7xEGs0VQ8C7Z13cB9OU5SAamOgWMLc8IFwhTg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FZwpmfSuPHGmOvuFpMc6x9vqVvaoIIIh2TQXheTQda6MgaBzAblRoKpSDRG7CdNnEnYkQNrndHDg738L30AVbNAi6xEeqPh1Fal+3ZVtO3HNNz+cx4uQgZ7Pa1fboxdgLv4GseIyR2nZqW33vzV00JPVv4yR8GAH5AR+adRAJug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k0ibvlJR; arc=pass smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48373ad38d2so11165e9.0
        for <cgroups@vger.kernel.org>; Wed, 18 Feb 2026 11:15:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771442142; cv=none;
        d=google.com; s=arc-20240605;
        b=Z1CZfgbfAftY35XJddKyIWLJtUt7btQXp7MgDX3LhRnA/pVN4jzPKlmZUp5m1Lhevp
         5kzDlYFYUsOytp6FGLwXkyBiAg+8p4MFldp3ByOB+SiwDPBbWInKKNS8aQqkfkB1fOON
         8zhhiZ9XnOT7H3Ka5qz3/DRUq8pTv+E+iXavYPI2A7Orl5v0Cvo6bgfPDCY4f18r2EwT
         ph8Kuwl+EHH46LLcZz7K4/VZnunjgWk92VXvGx+rcfQoSJ9hIpDMO3MCP/kSeGb0Wcjy
         7o8vEvMjHsGFJ1MF1/8WzhM1nIZ9Y9ej8iU7jhE8x00uJExxdxsrT/UehxaL+5Fdiv4K
         dJww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uYEklyyKGYW2ZvnMpqijJPxd6tx0mQrMdEMbyIKAW9M=;
        fh=okPxSJ1g07uumOLRN53j8ILDG/PWtYfVDY6lL7+VvN4=;
        b=Q/FeRGTI8WXcID2Cko6IC4vTDPdrxiaXQpoJ9XIg6m1iyrVBtJkYcF/Xb8U4RkV33T
         6XEkW2zo3/2hUmEI2WvzAW96NPzlxfXiF5W4wwdkqLrw7YKIWxvKX5ib8Tidy1LRpddU
         v+wMe5r98F1NQjNtv4os701XU+fDAmOZne/qGwq9lc3ZRFzjYD/BXwpRU8UD8SnxMVkh
         hB9PclHcW/rTDCvPIZk1Cumd3BJYKpVuIdcBmOAsScHFP3fD9yMpkO0RplVcs5DjnNyy
         3vYHnXlmcKGUmijHOc3oPmD4GwC6FPb3rWDHW+s5hNIZcRGeM8i1mAzYpB8zm/x+ZLKa
         f5LA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771442142; x=1772046942; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uYEklyyKGYW2ZvnMpqijJPxd6tx0mQrMdEMbyIKAW9M=;
        b=k0ibvlJRy1mVTRq7VYvbD4vaR8CC+E9EOCFYxbBvEcMiu+Tx0WEqNyYt077TVXI4yn
         Aet3xzHkFL304zxjRw0h3hq0DzVX8UgdfAHMymzQHth53T4mR8Yz1OKBwgCp/1m3+ann
         6QI/xLjsH3iGr4iGgLb+1xuFdaiEHHWGf05T2CfVH61JVQ6+17ww0WHB+9n4kSQ2J9fG
         M4eYQCasoQ1I5w/stnTD7P+A3zgag8s9G3+VD5XgSYLGN0OwNouBin3NRWee/u4WyEVf
         u6uVCTNq+2mEvXK5kybJ4rTyz6P6fn9WBz1RX9KLSV4TDumLZdYcrJqjGXej9ABFek4q
         3uBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771442142; x=1772046942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uYEklyyKGYW2ZvnMpqijJPxd6tx0mQrMdEMbyIKAW9M=;
        b=FYYvqVjrMtd9odW+3fFMZzTRay+8PHEujmIDa0Yxsysc0QR2go58lml3l9m9rAMt2E
         ZrXD8dqPlq9x9ldo+F/fptjuKoVG9LJE2dfm/90vc6izz0plCD+SJqIxLYCcaanin/nT
         ARYEqied8cvrl0xPL3/4/14ZDQ0y9OUEcwAeOhNFdt3zAtxRODXsN38XteOj1MAPXR2y
         TZ+JUiuxnkLrHBRxpdflq85jWkzb6rlqELnOJw/GJin2j7KjoFFAjzjsaZwxkWI/HGKE
         WJ6qO1hnJ9ekFxkhO3UbknDmXuEQ/bpp9MI+GbY8055L6HQJn2Z0oNRl2RNk/eDgIQ55
         hSkA==
X-Forwarded-Encrypted: i=1; AJvYcCWxDUN+1aNxnkI70vMY33Smr3cm+OdVtz1XxWvymOv+7KM8QCFEM3tMgHnMMtUtAdkrff5G4zsl@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9IhvOrwJtWZBCZqHguoqk2oir2slPHgM+pJ3NXLapR9lWvb1s
	G/EuF9Em0xggVEZ+Uf27jml3jqD2hoq01LgtsiganpCwEZvJX8iVVOFOIcJoU9//zbqGfdiOc2e
	9Puhx74lo8PNMkxCiW7NasOIQHhJ60K8JwCWLdOq1
X-Gm-Gg: AZuq6aJjMafYCaRdLG92/guQtOb7hRo1lpi1Fb8cBbzYJcY9xKiZi+4A6LWwyROV55V
	IpvcGtgW1JjCi0oqVVyWzD9MLrmdsyS5ZSenBXokKpWvMwwL7MKFP/IekKGeW7nPpDJ/nSlDfdQ
	9A8pxPiWYMc/P+Nn3EA3KZdYRMxoxrSxhvUpr9lBafAIQ1BPXUsCjzO+unpb0BnfV2ko4Btx1xh
	66hjwmNOZzHvYM9/7j58cDVqCN21nb68pk9zk9sBPMmBcN00OCi3w3x7496ZfISUoaBWBkztq2Q
	F1cb41Fm/StggLlEcl/yXisP2w7Mk6op31SdES6fCapvbuqdeif16I6bEZVpYn8RYgsqcg==
X-Received: by 2002:a05:600d:4452:10b0:483:6a76:11a6 with SMTP id
 5b1f17b1804b1-4839e6312famr23405e9.5.1771442142133; Wed, 18 Feb 2026 11:15:42
 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260218032232.4049467-1-tjmercier@google.com>
 <20260218032232.4049467-3-tjmercier@google.com> <e7b4xiqvh76jvqukvcocblq5lrc5hldoiiexjlo5fmagbv3mgn@zhpzm4jwx3kg>
 <CABdmKX1S4wWFdsUOFOQ=_uVbmQVcQk0+VUVQjgAx_yqUcEd60A@mail.gmail.com> <s4vb5vshejyasdw2tkydhhk4m6p3ybexoi254qjiqexzgcxb5c@ctazolc3nh6f>
In-Reply-To: <s4vb5vshejyasdw2tkydhhk4m6p3ybexoi254qjiqexzgcxb5c@ctazolc3nh6f>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 18 Feb 2026 11:15:30 -0800
X-Gm-Features: AaiRm53wtP0XVPm7Td49NxqM3FHtwAMm9Y-nYQJjMavu1aBdzT7jkoJc9BaBFyc
Message-ID: <CABdmKX2cQCneFyZhTWmWYz-RTmAOQcEKh5ZQewz25E6Xfok1tQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] kernfs: send IN_DELETE_SELF and IN_IGNORED on file deletion
To: Jan Kara <jack@suse.cz>
Cc: gregkh@linuxfoundation.org, tj@kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, amir73il@gmail.com, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,lists.linux.dev,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-14006-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tjmercier@google.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,suse.cz:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CBC66158F68
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 10:37=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 18-02-26 10:06:35, T.J. Mercier wrote:
> > On Wed, Feb 18, 2026 at 10:01=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Tue 17-02-26 19:22:31, T.J. Mercier wrote:
> > > > Currently some kernfs files (e.g. cgroup.events, memory.events) sup=
port
> > > > inotify watches for IN_MODIFY, but unlike with regular filesystems,=
 they
> > > > do not receive IN_DELETE_SELF or IN_IGNORED events when they are
> > > > removed.
> > >
> > > Please see my email:
> > > https://lore.kernel.org/all/lc2jgt3yrvuvtdj2kk7q3rloie2c5mzyhfdy4zvxy=
lx732voet@ol3kl4ackrpb
> > >
> > > I think this is actually a bug in kernfs...
> > >
> > >                                                                 Honza
> >
> > Thanks, I'm looking at this now. I've tried calling clear_nlink in
> > kernfs_iop_rmdir, but I've found that when we get back to vfs_rmdir
> > and shrink_dcache_parent is called, d_walk doesn't find any entries,
> > so shrink_kill->__dentry_kill is not called. I'm investigating why
> > that is...
>
> Strange because when I was experimenting with this in my VM I have seen
> __dentry_kill being called (if the dentries were created by someone looki=
ng
> up the names).

Ahh yes, that's the difference. I was just doing mkdir
/sys/fs/cgroup/foo immediately followed by rmdir /sys/fs/cgroup/foo.
kernfs creates the dentries in kernfs_iop_lookup, so there were none
when I did the rmdir because I didn't cause any lookups.

If I actually have a program watching
/sys/fs/cgroup/foo/memory.events, then I do see the __dentry_kill kill
calls, but despite the prior clear_nlink call i_nlink is 1 so
fsnotify_inoderemove is skipped. Something must be incrementing it.


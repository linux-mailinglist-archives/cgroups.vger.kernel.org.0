Return-Path: <cgroups+bounces-7500-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF58A86E25
	for <lists+cgroups@lfdr.de>; Sat, 12 Apr 2025 18:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1C6C7B3B12
	for <lists+cgroups@lfdr.de>; Sat, 12 Apr 2025 16:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9D71F7904;
	Sat, 12 Apr 2025 16:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="abaBpV7J"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3681E7C10
	for <cgroups@vger.kernel.org>; Sat, 12 Apr 2025 16:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744475853; cv=none; b=GYhcQ7en6N8dDZmAlCHoL/AmGw4kP6hrdoOH4AC/K3Gf0olj3O6ENUbPblqQbDxqkp0LcCBkOD5B5KBkfP5T3lfVnYzcRM4fB+D7lXGSAW5IF39HIeOWkn3PcrQdMl3QHeb45E3AepHdSAv+emaJ7ph9jW7aGIFN5xBIjlUe3tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744475853; c=relaxed/simple;
	bh=3nlQeqLpakx9VbjVGGaVN/AwOVYMXPCNfTYZtnneuv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ohUqdSrUmtWi/gZIDyyEDjFBfDvlOL5Mm9DRGkFd1W2D1lF+ZXDgW3xUhoaViKsmjDIDFWJmwTiimyvo4kBKisQA215JJSLFR72yaqkdhdl4sLfWN2MecxTIciEk596rBLHMaK2kQ+aMErILFspw37bYQ4wkOkxQRv7Rc46X0Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=abaBpV7J; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744475850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a3fiFsru6LnJQq9k1qZHmlYdUChXvApej+AwnAQ3uLE=;
	b=abaBpV7JPRwVTf2QqGPNcLm1RtEi+ptRoy7trLUtn6jKP0Rrhq6Y2zq5g5hsX+ssvvesfD
	ItG33TloUqJDTxK8UGjrdwums+O4ElaWp2MCkjBxYZZF1b4qHyNbxewaZE3dXpwNyTSWJr
	eD46/ZjzlWzQs6abtDOnqoAksiDbmdw=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-RXw7gyODPa6GKyz9boCxVA-1; Sat, 12 Apr 2025 12:37:28 -0400
X-MC-Unique: RXw7gyODPa6GKyz9boCxVA-1
X-Mimecast-MFC-AGG-ID: RXw7gyODPa6GKyz9boCxVA_1744475847
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-224347aef79so39207005ad.2
        for <cgroups@vger.kernel.org>; Sat, 12 Apr 2025 09:37:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744475847; x=1745080647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a3fiFsru6LnJQq9k1qZHmlYdUChXvApej+AwnAQ3uLE=;
        b=ii0JiDRxvDojucb/PPpL0T4mhp5BOHuk3X8rtLmRTg6+Ukt+I6+cTgL6fmKdsCEqsL
         6RQttJ/J62QB90kVk2Sq1lCHsCKvm7UGOA2/dPV3L4Dks16w8+NLAQOw5QhKWUu+3t7o
         F4yO9nE1TSAWQMuUJTfmi8facwDm1xdIfAvgyM8vr5BTla1twn3sD4p0ATwEZKfHdVuv
         DyK+aQqwuaUTtuF9sWnJxv6/LbNkBojxnDmKWv93ZkxC4h7URxphfUwh5iRjoq7+N4iv
         FAjRDeoBjBMKq3+F1KKfJp8KpuNWKHinmEwW9uE3HCFdqkJAGfzO5moXb6MyZ4Cq/yV/
         aNUA==
X-Gm-Message-State: AOJu0Yy1PlkwL7w5inJv8Zs1s+O0/9OvREcYu///f+qUPdTcLochZuIO
	S0uAoh5DQn+WeAg4u6REpjsjR1qYKCAD+ueAkVCRJU1eHtL/n5gPJglEZ1LZ8lN1HzOzMMfYySX
	lf/8MprrXvEgBdi+IUCFIYyz2oOmpdI3byLQ+H4Y9wRiSW9mslMY2NnQA68bqr8i6rUlEC6J1bY
	oekWV1wTUEEkgqvj7zQE7PBWLnaNeDPA==
X-Gm-Gg: ASbGncuV8aTSmQlgH/wjf5BhNXJ1SBnsDSbKMnvnXzgZ2JrBAPWzJfSnlox2DqVF1oT
	nB04vPh1nk7tcVvK/3WTMxSjwsx7jSxHlvugj9x9u0EgSxq5QDNg52Zz5QsjDKzls0tk=
X-Received: by 2002:a17:903:17c5:b0:223:5ca8:5ecb with SMTP id d9443c01a7336-22bea4efaaemr91129675ad.42.1744475846938;
        Sat, 12 Apr 2025 09:37:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7sLLGDrtrxmDABKermY+/WFSctIXR5dmHRBwVPDD2cHAaEfr8X4dND2BPeABs3RlvZSRMNQ6ofK7p0cF8CSo=
X-Received: by 2002:a17:903:17c5:b0:223:5ca8:5ecb with SMTP id
 d9443c01a7336-22bea4efaaemr91129475ad.42.1744475846684; Sat, 12 Apr 2025
 09:37:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250411173848.3755912-1-agruenba@redhat.com> <c9014d1e-c569-4a7a-aa68-d7c32e51d436@I-love.SAKURA.ne.jp>
In-Reply-To: <c9014d1e-c569-4a7a-aa68-d7c32e51d436@I-love.SAKURA.ne.jp>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Sat, 12 Apr 2025 18:37:15 +0200
X-Gm-Features: ATxdqUEc6bK4RDS8nTPgD4dEmZc4tgzp1L5AosoT3RAQjOcAirWwydpqqoRpyIw
Message-ID: <CAHc6FU7XDXCE--4vtH+q94NBZK-ScYSLTmeY4+J9T9YH7BtR9Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Fix false warning in inode_to_wb
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: cgroups@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Rafael Aquini <aquini@redhat.com>, gfs2@lists.linux.dev, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 12, 2025 at 4:21=E2=80=AFPM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> Please add
>
>   Reported-by: syzbot+e14d6cd6ec241f507ba7@syzkaller.appspotmail.com
>   Closes: https://syzkaller.appspot.com/bug?extid=3De14d6cd6ec241f507ba7
>
> to both patches.

I'm quite reluctant to acknowledge syzbot for this. The bug has been
reported several times by several people, long before syzbot.

> Also,
>
>   -static inline struct bdi_writeback *inode_to_wb(const struct inode *in=
ode)
>   +static inline struct bdi_writeback *inode_to_wb(struct inode *inode)
>
> change is not needed.

Ah, not anymore, indeed.

Thanks,
Andreas



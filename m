Return-Path: <cgroups+bounces-7541-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6A4A8901D
	for <lists+cgroups@lfdr.de>; Tue, 15 Apr 2025 01:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF9143A4DFE
	for <lists+cgroups@lfdr.de>; Mon, 14 Apr 2025 23:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C301FFC54;
	Mon, 14 Apr 2025 23:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sc9l5Q4d"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7391F4163
	for <cgroups@vger.kernel.org>; Mon, 14 Apr 2025 23:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744672967; cv=none; b=CrbnS44Ys0kl8VhH3Q/op+miK06KdEIpPVEVIonWGCl0k/wmTKiFOXiai576zTAGZW05EKyhN4fzdg0SpCBcmjcPAP+70QBXZ1T1lFlNzda5pQ51VWAQhVWEV6/uWolc/GTILWk+XIbnUc7HJ2Exs6nXN4t++es96qpn3qIqd+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744672967; c=relaxed/simple;
	bh=4DnMfpFmbLxGeVz6jjMyOFFoUcbKIrrGS/xuWDmkbAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TABbDFKSCxppimcHN4UPF82t5bG+FHqhhA98R9o0sEAfPFdyMrU8NAiDqvTtqA70h9dq/Nu5C9FYNU8l7cETUe/cvKKA3q/S1CZOYe2dw5COc1vsuQ7yRmavJoCj/z4GvciKGMsVlYlOYQvuMnH00o+E4CPkeQ+zx5jQlG6uuxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sc9l5Q4d; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744672964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fTqOfhVMO3oX7s5hEfhf7N6UJGTux5HLcHvFLo78+oQ=;
	b=Sc9l5Q4dKvgAYKJoD0U6SwPUWlp07hIQraZzmo23vocSTnG1ufwQqiQUPb0LkKmoIXwUQ9
	KEKOJYiW+x0xt3cDtEdcOrfjqWSCe4HViqK1w6fDd2LMUYGzRiYUlhJTWF4bPtJ7iYvoSO
	vxIHxKnWw4FCXnMeeQ0lWTQcajO5cjI=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-1SZ3V0dJN5er_bD0EmX4QQ-1; Mon, 14 Apr 2025 19:22:42 -0400
X-MC-Unique: 1SZ3V0dJN5er_bD0EmX4QQ-1
X-Mimecast-MFC-AGG-ID: 1SZ3V0dJN5er_bD0EmX4QQ_1744672961
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2241ae15dcbso55224345ad.0
        for <cgroups@vger.kernel.org>; Mon, 14 Apr 2025 16:22:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744672961; x=1745277761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fTqOfhVMO3oX7s5hEfhf7N6UJGTux5HLcHvFLo78+oQ=;
        b=AhTetoYWrQrYDyLxsDnd31JLogeiWbjmreNF2B973knpBbBUeI327tlA0hHboZ0MX9
         8GRZvf09DO++jJWbUqn0SRccavVm9ALb+acRpPYYYc67KlImL5uUr/KUMHvcjSd3RBJy
         5MvLUHyJGd9orGb+HMIETgcL0d8nZ8wbonbSQHnnbnVCPU2PreQ7Rdrng5IGz+gmVbxJ
         O+fcgDx6ha5fd/24RONu9D9SDgBoz07YjK9DE0bXRCwkpqf7SiGjHPnqEl8/PTpfr8v1
         j/W4AQqd6N1+aKIlXloj2kOiQnbalTHPTxejwP7ejhPBLCFKIgUeaiF3ccteBduAO+Is
         2D3Q==
X-Gm-Message-State: AOJu0YwdF5OEHZzZIgL/s/3wkPHoyO+mHtVJ+BoXKiGoq2t5COxpjy+e
	h5GY/GqlQ1V4pgjdSE89ZP5st5Ddr1Ha97yOwSoBvmlz9iYd8YlGd0ox7MgXSg+t59kQ6FESVbu
	tQ8llbTWrU3T6JMdbUeZ9NecMDnR1JOdY1rM6yVidaaItMDxgxNuSBZ2/8nhHx601z6jpA2A/R9
	+nLSj08m4I3s7gOnnPESAmEwiKRYT/+w==
X-Gm-Gg: ASbGncuH9LRHn5mZrcxUyCE5f5/MoACyg9EwfvQYbctuubdXFNjh9+wJBBgBLFuntdi
	dzx7OHsQE4rIVTyFih5kHvudA7Wbx/vo5IZnbezXW07sw645esXsgx2j8azMtZEw5Dik=
X-Received: by 2002:a17:902:ea10:b0:21f:1202:f2f5 with SMTP id d9443c01a7336-22bea4a1e41mr165046195ad.8.1744672960905;
        Mon, 14 Apr 2025 16:22:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1AHsKSZHKc3ZG9l2EOP9IVYFBrGDAU7Mxy/wvMCYvA1yfGQ8huWiBkzCVojnxML9vlgqyT86Cp7v0R0BshkY=
X-Received: by 2002:a17:902:ea10:b0:21f:1202:f2f5 with SMTP id
 d9443c01a7336-22bea4a1e41mr165046005ad.8.1744672960646; Mon, 14 Apr 2025
 16:22:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250412163914.3773459-1-agruenba@redhat.com> <20250412163914.3773459-3-agruenba@redhat.com>
 <20250414145120.6051e4f77024660b43b72c8a@linux-foundation.org>
In-Reply-To: <20250414145120.6051e4f77024660b43b72c8a@linux-foundation.org>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Tue, 15 Apr 2025 01:22:29 +0200
X-Gm-Features: ATxdqUGev3hKkKP_xReo0nZ3C7cPj6MnUdmVFecbVAT6bl5u52ieWp2nkeKtLgg
Message-ID: <CAHc6FU4CAzrNO24izcwYXFt-K0WFUdM6y0bAzmW6nb1CS0sexg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] writeback: Fix false warning in inode_to_wb()
To: Andrew Morton <akpm@linux-foundation.org>
Cc: cgroups@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Rafael Aquini <aquini@redhat.com>, 
	gfs2@lists.linux.dev, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2025 at 11:51=E2=80=AFPM Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Sat, 12 Apr 2025 18:39:12 +0200 Andreas Gruenbacher <agruenba@redhat.c=
om> wrote:
>
> > inode_to_wb() is used also for filesystems that don't support cgroup
> > writeback. For these filesystems inode->i_wb is stable during the
> > lifetime of the inode (it points to bdi->wb) and there's no need to hol=
d
> > locks protecting the inode->i_wb dereference. Improve the warning in
> > inode_to_wb() to not trigger for these filesystems.
> >
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > Reviewed-by: Andreas Gruenbacher <agruenba@redhat.com>
>
> Yoo were on the patch delivery path so there should be a
> signed-off-by:Andreas somewhere.  I made that change to the mm.git copy
> of this patch.

I guess that's fine as long as Jan is credited as the author.

Thanks,
Andreas



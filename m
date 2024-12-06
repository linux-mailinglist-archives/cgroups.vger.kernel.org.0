Return-Path: <cgroups+bounces-5775-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8519E66EC
	for <lists+cgroups@lfdr.de>; Fri,  6 Dec 2024 06:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1B2816A229
	for <lists+cgroups@lfdr.de>; Fri,  6 Dec 2024 05:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ACA11990C2;
	Fri,  6 Dec 2024 05:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S1naA9C2"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D2D193060
	for <cgroups@vger.kernel.org>; Fri,  6 Dec 2024 05:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733463276; cv=none; b=MEHD8mxKVd3xgETz4B40pOoCWWc6a0/e69R9VwaD9eWmWT79Sb/ZF5TZHS/DxUs2+UE/2eAGE19Jgl0N0xs8nDqze6u9c9trikdbIDAtaE7JfCjSOnqSoY8+ZeUGJUDRDgL2hP3vU3XNe0VvVnjnYt2auAn/hTGFEvrorB+Qjbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733463276; c=relaxed/simple;
	bh=16KGT4gLtqp9hrwwvR1/YXm4X39dxUtnEO49CGuLwJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p1NWNR+9MmqfArxsw7PGmjUvcg54/JKJGKlWc+tVuGvRU/Hg4UXbLUBKlEW47iq1Xr8YgMwi3ZGTdn9OMLeXlG+D48H60dNHsqI8C2mUEMHROuH86zwb9hMpxWOUVKwVQ23LYng5Gvtf4js2EpqLvi9qH2zNoczdGml/1G+fBSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S1naA9C2; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-4afce5fb033so146959137.0
        for <cgroups@vger.kernel.org>; Thu, 05 Dec 2024 21:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733463272; x=1734068072; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=16KGT4gLtqp9hrwwvR1/YXm4X39dxUtnEO49CGuLwJc=;
        b=S1naA9C2WAgRm169SwhmTtuata8ctBLQftn5LMI6/GjkdtUp2TLVcAHBBoeaCh/VMQ
         6eddvNXVWbIOBVhnczLdC0pSOXywXSSnotYu6jQ2ijI92Pxwqvl2ReI1OpsyOXo9JH7t
         qQcQzZo7t7UGRIb+azQWZCN3i/88vptYsbpMJDtoShl9Qha+PtwDo8FiY54TySH/aZla
         RUPRDrlSJYeddlLjyllr00HnAV/HsXzxN6M2fehbVqMR3OBYECe2vL3E069g/oPR5bkJ
         M2LCz66sgipGSkd5B7GDVoRBmbV3JW91uOBV0Quc3Da9FRpWSdA7+YvMp1krgHVbuY2/
         Y4jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733463272; x=1734068072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=16KGT4gLtqp9hrwwvR1/YXm4X39dxUtnEO49CGuLwJc=;
        b=NTHHGDT85rIoTzvj0XYyU0u2QbSy7mvTwjSP1NXZfL2UeIi3um901VXctU8E/C61AE
         AFPUdtQG7+kME9bpmV9040iCPH0r9rTCPr00+sQLsID+aJmJYq0kBzZP9zURlgHqD2GY
         +9QVM38YxBjnM9MpHu7LrChOqhx0W70GNywXK5NYlPeowbn9caRT90KU9Ytr8LERrt19
         K3DWs0Sss3UBk7vu5frVpBO195l8/wY5K+WfXf60c+Dpu0ljx/Q0PZSSYNSTvvHxZcY4
         WvENlIZ1FsRJ5oqL2YPHXpke2yV4wZ+RBa/9VDNxz7kSyhrdrJ4+H7lljLGeC/kro7Xg
         NNGw==
X-Forwarded-Encrypted: i=1; AJvYcCWVYZ5ygIpaxMeiGFrrEKKitjcabOjy313OkmEv8sd9dpBxg5BNRavNQJ/e/cIfJX6T/DwlEw6V@vger.kernel.org
X-Gm-Message-State: AOJu0YwCrxXfKuA1aoFo7IWSRA46t4KddFYa1FjTdirDt4iht9pzgoJ+
	q7P+mKDs/kxEAGxAh/VE+uoa8P9PXI7N6E9fozHho2moeeLlQr1mJ9oNLUsfBZUwA/Vkh9rblyE
	PMD2j6o4CZbFv+Edk3PciSdO/jF8DHBqLlWEw
X-Gm-Gg: ASbGnctOG3qZHv1OVWy18HPw5slwbc8dX1qc+ed56Ethz0FnSsyT7evZCuegvbMPSEk
	zkAEJPpYtn/JRr4ogJ1oQp+uRKMGgeWNcetVehkfRRO7sPu2g1QUEBa8SX1z8csLv
X-Google-Smtp-Source: AGHT+IEvLPcxcG6dZYsc3RKvBr2mvmoMEUY4/wcnwdmAjPDkJVyQm0dyThNYTYOoPk5dcYLaVciUxeWQ2PRBVfQ8Qbo=
X-Received: by 2002:a05:6102:5493:b0:4af:586c:6197 with SMTP id
 ada2fe7eead31-4afb9345c75mr7082003137.0.1733463272304; Thu, 05 Dec 2024
 21:34:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206013512.2883617-1-chenridong@huaweicloud.com> <20241206013512.2883617-4-chenridong@huaweicloud.com>
In-Reply-To: <20241206013512.2883617-4-chenridong@huaweicloud.com>
From: Yu Zhao <yuzhao@google.com>
Date: Thu, 5 Dec 2024 22:33:55 -0700
Message-ID: <CAOUHufbCCkOBGcSPZqNY+FXcrH8+U7_nRvftzOzKUBS4hn+kuQ@mail.gmail.com>
Subject: Re: [next -v1 3/5] memcg: simplify the mem_cgroup_update_lru_size function
To: Chen Ridong <chenridong@huaweicloud.com>, Hugh Dickins <hughd@google.com>
Cc: akpm@linux-foundation.org, mhocko@kernel.org, hannes@cmpxchg.org, 
	yosryahmed@google.com, roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
	muchun.song@linux.dev, davidf@vimeo.com, vbabka@suse.cz, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, chenridong@huawei.com, 
	wangweiyang2@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 6:45=E2=80=AFPM Chen Ridong <chenridong@huaweicloud.=
com> wrote:
>
> From: Chen Ridong <chenridong@huawei.com>
>
> In the `mem_cgroup_update_lru_size` function, the `lru_size` should be
> updated by adding `nr_pages` regardless of whether `nr_pages` is greater
> than 0 or less than 0. To simplify this function, add a check for
> `nr_pages` =3D=3D 0. When `nr_pages` is not equal to 0, perform the same
> actions.
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>

NAK.

The commit that added that clearly explains why it was done that way.


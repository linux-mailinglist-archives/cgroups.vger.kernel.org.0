Return-Path: <cgroups+bounces-5129-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 536D799F525
	for <lists+cgroups@lfdr.de>; Tue, 15 Oct 2024 20:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D016D1F23012
	for <lists+cgroups@lfdr.de>; Tue, 15 Oct 2024 18:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E411FC7CB;
	Tue, 15 Oct 2024 18:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkZGuQYx"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7668617BB16;
	Tue, 15 Oct 2024 18:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729016650; cv=none; b=U7HVrXyRhyO/BahyLo2+c6TZcYHCPqJHAB1sJuQnTf1+1y8HauGGzCpQgjco5RpF0vNNBT1fuKAsWn/3UnUHjka4LhIT8Kutd/M50lCRzXgSB4hwK0d0ehwUJq0o2iNv5u1UIrCjvQQblcIdleStE3CpJZ3S2E5h8CxnzlONuqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729016650; c=relaxed/simple;
	bh=cBQbURD9gtJ27C7LhUadVs07AFWdlIg3dabfytVFJ1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ppqy97eTc2+Iewwap33hLIwmWnNtJeHECKpsaKkxup6UKKkYufzysldTBIGIlxJ1VGQ4y023rBKx4AdwAhU5ySTZUj1B/4sOY+6V6cvjsJ9RINJt78IdGLbaZFvuHqJdgdc8gYY/OLuMBRuU4NaHmzM1XhLDySi0H+0kYhJJ8JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YkZGuQYx; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9a099b4c66so38204866b.1;
        Tue, 15 Oct 2024 11:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729016647; x=1729621447; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cBQbURD9gtJ27C7LhUadVs07AFWdlIg3dabfytVFJ1g=;
        b=YkZGuQYxV/sMl/oOAEkVF40TKV4hHz6gsysnXTs6jXBJTgpfLT1g1hgbiw6jEm5CH7
         086s/9386K02sVSC0TDQzSoFSF/snsj2T7FTT3q44hBOznyx5SsP7L7If9duqGy4zBMg
         DKga+4dbmP1Mdjw3cuCpO6zPNW5hy9qXL1e1O1RhM4jVdCnGqiHd8/u/NmIZcr8PJvgl
         deq/xBVPlrEr6ZzShQcN6yxBERI7l+AOOJWobQAJrV6fWoVMDGsp5bseCmhvVxg0xv7C
         r9z/y6595c6tX1dQARabyzMGyr+4Na2Q3kbSBibh5MnkfoVF2mraayM0YAsxGkhcC3hG
         a3ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729016647; x=1729621447;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cBQbURD9gtJ27C7LhUadVs07AFWdlIg3dabfytVFJ1g=;
        b=HjIRs2kzV3qU0JJwE5FsxgjNM80UDiQPzUHrRzfHdgrnWyxqgxrPO60hpb5iPmXJ4P
         5BDADcHJCsiwbBd4Xm54L1ShLEzSlWr7I18MEuKAgE5pvlivuAG4GRvPcEud7M/Bi1cQ
         jsqQoiJLXHTy8vlTfK/97ojNdBGebUPThMWSCKlnzNY2u3XLNps3uL25Mr8FVAWZU6X2
         cCQaKLPw+CkuF6AEdsPbLsqnJxyU6Nh1Ner4IBJlk3aL4ytw9Z1fSQfjIHjheeqK4Wai
         k/2EKEZHptxtbnsxgtohlqkTXKqsriUT4Cqo0+V3ngxgi0ubx0QcqeyMT8ynGcRpFrf/
         21Qw==
X-Forwarded-Encrypted: i=1; AJvYcCUifEsWkWllHHBj7uGh9K3aqZ9IS6hFtFckiNbCRlbfJaen5yHuIeV7rymv6yQ2izOlcfvM4mlUvcy6XBom@vger.kernel.org, AJvYcCWoh/fmv1LXXTWy4tZ7x3G8mv8bp6x6mATTulTvI4N3MtKqLJJh0n17BZntXLpZaKC2Vk/xbsEQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwVnJj4upS+p5URnz3SDqTZD++axhWvrPjkeHmeD3hXVxyu6F0x
	Wc7zuThwHqOEtxls/O/zkdE40m9aknerdb82WsabMG0mfPo6wSKE6LCxRPFGaEUmDKG2EhBpgbW
	OJwZdNv621qWiKFC1JGDZH6RmT6I=
X-Google-Smtp-Source: AGHT+IGy81Amdyb3jOOg/w+E46xcBY5DrRVu2jjisvT8uZCR4qImZeIOyuj/wVBNuuuj7X9XGja5HR/qvfTIyoHhqU4=
X-Received: by 2002:a17:907:9449:b0:a9a:2afc:e4dc with SMTP id
 a640c23a62f3a-a9a39cd4d55mr4148966b.11.1729016646579; Tue, 15 Oct 2024
 11:24:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJg=8jwFexnoTfPLg=Yd44WFVn05wAn0UgH6=baipc53mDxgyQ@mail.gmail.com>
In-Reply-To: <CAJg=8jwFexnoTfPLg=Yd44WFVn05wAn0UgH6=baipc53mDxgyQ@mail.gmail.com>
From: Marius Fleischer <fleischermarius@gmail.com>
Date: Tue, 15 Oct 2024 11:23:55 -0700
Message-ID: <CAJg=8jwrXQm19K9YpBuX=LQwwq1cDSpP6ez1XRRE7mAg_8_Xiw@mail.gmail.com>
Subject: Re: general protection fault in bio_associate_blkg_from_css
To: Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: syzkaller@googlegroups.com, harrisonmichaelgreen@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi,

Hope you are doing well!

Quick update from our side: The reproducers from the previous email
still trigger a general protection fault on v5.15 (commit hash
3a5928702e7120f83f703fd566082bfb59f1a57e). Happy to also test on
other kernel versions if that helps.

Please let us know if there is any other helpful information I can provide.

Wishing you a nice day!

Best,
Marius


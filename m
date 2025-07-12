Return-Path: <cgroups+bounces-8712-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B730B0296E
	for <lists+cgroups@lfdr.de>; Sat, 12 Jul 2025 06:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16EDE3A376C
	for <lists+cgroups@lfdr.de>; Sat, 12 Jul 2025 04:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0898E137C52;
	Sat, 12 Jul 2025 04:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="flDqUDJj"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299D854670
	for <cgroups@vger.kernel.org>; Sat, 12 Jul 2025 04:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752295893; cv=none; b=as/fHfQGaopcGf1FloQpy6kEJVN/f40K2PFsLzPZiy4mHwXfrRDTuXADQdN8AcTYMmeGTzDuL8VfYRvk86o2LzmdTGeqX3pk+faCkFEAQ6iwnic86cLkLVE9g7ltPWfq5Y7lpkuDgT8ULSEy1NCyd5ANkO3yJVVsIJ3+ACxbtFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752295893; c=relaxed/simple;
	bh=050SvZEhZz4jAff275QOyeb42faajvwYRTWt0vORb2o=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=cdJ1W4rEwCdE959XCTenN5XoC0Tl7wfUOPnr6D3CGi45hMH0/TLcdzCca4kSofJmCNPAmOzV5hqfeSf3jzGl0NQCV1EHRovdCxD/sqDYmebFZ2FynH4sLI+uwVJ2jmiGqhFfIGxlCipF6kD9bIXF7OmnB42Oo+odPKEuo9YxEqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=flDqUDJj; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-558fc8f0750so3294053e87.2
        for <cgroups@vger.kernel.org>; Fri, 11 Jul 2025 21:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752295890; x=1752900690; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=050SvZEhZz4jAff275QOyeb42faajvwYRTWt0vORb2o=;
        b=flDqUDJj63dW4BUzK9fhnl/juvxUMDJHrlRUzpTgVn+McqVMHqHFWL+clQkXMBmfsk
         7KR2WAMVquN48+Wq7AXUGTtQsC6aL7CCmDBrJ63ckIzMojwicOcuLr4+6S6NrQ6UTvNk
         eoZrd4a7PbH82J+TP8EzHanuJqcxBBWMOCI4MP9IAGZ01HFJ3lOce0/AqwpVGCP+oMR4
         1Uz2/ZIFrgdxOuBXNjUcujNgiUlGODItf4MEZRMeKJV02k4mwNabA25DCUozaznKVh/z
         X7BLRfItch811VhR5SbKHo0It9bPRfjoDMP6eX84FZZQado61mVOQvQewecAKAofYx0s
         X8ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752295890; x=1752900690;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=050SvZEhZz4jAff275QOyeb42faajvwYRTWt0vORb2o=;
        b=eDICg4PyHqE1xZZbW/FNbjxAe1WMkhQGbSoIgAkjxoC9pqPp08Jz3mwY5idM7+h1sI
         DC6Z6VovZHG0NKoeWKSlvW3wniY45IC7R1oPW3SUrdnISdTIdVg6CuCsEqQE+OlxMcmm
         7fIEYFQwf266u2WiKvzGGGGMJPvwNyOGYSMIOWWfqBOMvnfhILjPgZ94TZ+95nc1j1mP
         M+oRssRFKHb+ZZDpO/jXZ110Ug2mOdvGie2sS7fwl1zkxehl1x6iMUg4V/rjjIu+9rT3
         5UchrWybHz1eX13rSqLMbmZEPFEPnnwL1yf3+HpYbdlpvEjnSWvOeUSUqKDFPqN7T7JC
         h18Q==
X-Gm-Message-State: AOJu0YyX+Ekch5mDFkY/Ss8NdVz5GaZGAk59dZxcOtyBCKDgLgyyqMla
	N5S4oGiYLBzTlaLHraSt7kTbTVMj4pjdlxS8kmPOTqFRMX+b6ikd3fH8h5lREoy9CQUofF38tDh
	jEaPrmub0yoNFqQtEqz9cCBeMwQCaXF5Vlmi60yY=
X-Gm-Gg: ASbGncsjlvy8nWLC6Cue5cQ2YT3XtQUsCRi8806nOYExE2PJqH4blEdVkyh92yCSzzq
	UUnhTSxne5hNkmyqMuIn+Nucd8MVLK5x/kZOTU4dav7fuEHF2igFd2bBue85s5CrSg4QXFdti1L
	9/VF75D1H+WSWSSwLGYGBqLr1Pt3kcSupxQ7qmi90wT5g0EPZo3j1m9AEaRM05C/rK+TyltdC4a
	XwNMZs=
X-Google-Smtp-Source: AGHT+IFlP7Jw1LGMfAWDDU3G+3VbdCXAkbsLdSxT23sc4gpQjd8uNMmE+iQJjlizzDR+sKr7lq3nOQhPGTWTfSn2A+0=
X-Received: by 2002:a2e:a7ca:0:b0:30b:b987:b6a7 with SMTP id
 38308e7fff4ca-33053189038mr18744421fa.0.1752295889734; Fri, 11 Jul 2025
 21:51:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Xuancong Wang <xuancong84@gmail.com>
Date: Sat, 12 Jul 2025 12:51:18 +0800
X-Gm-Features: Ac12FXyBBlKsavUaTaKlStuzO3IpaoDpS2wLqnoJ4o3bQQXZIGZ2C1wYuKF2Yyc
Message-ID: <CA+prNOqAG31+AfgmchEMbeA=JpegKM946MZPm4TG0hEXDDRUag@mail.gmail.com>
Subject: kernel defect causing "freezing user space tasks failed after 20
 seconds" upon deep sleep
To: cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear Linux kernel developers,

I am referred from
https://github.com/systemd/systemd/issues/37590#issuecomment-3064439900
to report the bug here.

In all recent versions of Ubuntu (mine is Ubuntu 22.04 LTS), deep
sleep will typically cause the error "freezing user space tasks failed
after 20 seconds" and then the desktop will hang. To 100% reproduce
the bug:
- lid-close operation set to suspend/sleep
- sleep type set to deep sleep `echo deep > /sys/power/mem_sleep`
- SSHFS mount a reasonable-size Python project folder with a
anaconda3/miniconda3 folder inside it
- install VS code (version >=99) with Python parsing plugins
- use VS code to open the Python project, set interpreter to that
anaconda3/miniconda3 located on the SSHFS folder
- while VS code is parsing the project (spinning gear in status bar),
close the lid or run pm-suspend

You will see that the laptop does not go to sleep (sleep indicator LED
does not light up), after 20 seconds, open the lid, the desktop hangs
with the error message, "freezing user space tasks failed after 20
seconds".

Only reboot or `systemctl restart gdm` can recover the desktop, all
unsaved data are lost.

Cheers,
Xuancong


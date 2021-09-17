Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC31540F18A
	for <lists+cgroups@lfdr.de>; Fri, 17 Sep 2021 07:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244735AbhIQFP1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 17 Sep 2021 01:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbhIQFP1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 17 Sep 2021 01:15:27 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA50C061574
        for <cgroups@vger.kernel.org>; Thu, 16 Sep 2021 22:14:05 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id i4so27873643lfv.4
        for <cgroups@vger.kernel.org>; Thu, 16 Sep 2021 22:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=RzIkdEm5aJl66a3p0t6hmEQ+Qv+8MFJLxj5JlLxnEbs=;
        b=BkoLZCRrsPghhWYeWHaUXChEqPmEkb0et9CUiIKGE3sI19HF3nTJuF+ZbBCaYku2A2
         BfSF0I7fcIl8wEydWa1VoB1opcxthQUmujIZZwZeQz2nivbff+xXVo+ZUXCYTAg6B2sC
         E23Lo9OkGRdT8Na8IqmGjngoOH32hZpqifgLZ+2cSb0iwrmAzhlJ7Vp+CRhXlL2xXj2T
         LrqjkeLynEE+IG5+2uSR7OBlKgv7fANzUxB8DjWMRgzR/cBlhhhdHYA6jyceXxdHrWx5
         1PKBIHqGYpCaIVAYx3LSxRk0BhFyR4Fwd5j0SJiB+GxsDYmQXcNmtYwCbmZ+9pU4rA5O
         GcvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=RzIkdEm5aJl66a3p0t6hmEQ+Qv+8MFJLxj5JlLxnEbs=;
        b=F+G7WnrS2HEwbWzUnc+YD3QSJDK2ecHJWzlBcq0NS+f6rlAQi6ZHjlMD+bLFFQeIx8
         LcGVzrPJC2Bwe4s0SaQdsfDfs6M3j0J76fv5qvmj7NxSkvBuErDhb/kxPbuI0PapsGTM
         g4fNLXALRAyYmlMmomkivPrwe7lfLEVZXW/waKlxVG7iL7OeswwhFeSFBzr7v4tk9IOm
         Jfz+jexCtplQO0voc9NUGMv8Ofbp/aQ0DE8EIQ20jQ5NWCVR+GFRQcNOO9zRYP9gzRep
         kcN4Iqax5d1UYXSnM7CGz9OyQ2tFSvvLMr5UlDLWb3AjXuclo4mA3lKdwV78xb3hyoYX
         Gh1Q==
X-Gm-Message-State: AOAM530XCl4eE1DbCs2vqKF3E4ejLCJ6LVGKfwYS11+kaMuTcSFawaz5
        peWLuIOUQQriKDFwd2oC5n8OqlFdHFAYsMoSGgs=
X-Google-Smtp-Source: ABdhPJyU5q0ab86kAQJ3Q5T/Q6/n878IMwbv2W8UEqxESiyaTM29utHrwA6Iw18voVO6EU3YrTGEcAZdJ0FNNYs+Nvw=
X-Received: by 2002:ac2:4435:: with SMTP id w21mr6669046lfl.269.1631855643609;
 Thu, 16 Sep 2021 22:14:03 -0700 (PDT)
MIME-Version: 1.0
Reply-To: godwinppter@gmail.com
Sender: maxwellagusdin8@gmail.com
Received: by 2002:a05:6520:47c4:b0:139:1b10:ad9d with HTTP; Thu, 16 Sep 2021
 22:14:03 -0700 (PDT)
From:   Godwin Pete <godwinnpeter@gmail.com>
Date:   Fri, 17 Sep 2021 07:14:03 +0200
X-Google-Sender-Auth: S2TfFqKuSG4eAL_uLAKCj56Nols
Message-ID: <CAK5X1Sdn6n84dztNBiEfGieJUybpYYUhRosBfTNQckp-p1owWw@mail.gmail.com>
Subject: I want to use this opportunity to inform you
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

I just want to use this little opportunity to inform you about my
success towards the transfer. I'm currently out of the country for an
investment with part of my share, after completing the transfer with
an Indian business man. But i will visit your country, next year.
After the completion of my project. Please, contact my secretary to
send you the (ATM) card which I've already credited with the sum of
($500,000.00). Just contact her to help you in receiving the (ATM)
card. I've explained everything to her before my trip. This is what I
can do for you because, you couldn't help in the transfer, but for the
fact that you're the person whom I've contacted initially, for the
transfer. I decided to give this ($500,000.00) as a compensation for
being contacted initially for the transfer. I always try to make the
difference, in dealing with people any time I come in contact with
them. I'm also trying to show that I'm quite a different person from
others whose may have a different purpose within them. I believe that
you will render some help to me when I, will visit your country, for
another investment there. So contact my secretary for the card, Her
contact are as follows,

Full name: Mrs, Jovita Dumuije,
Country: Burkina Faso
Email: jovitadumuije@gmail.com

Thanks, and hope for a good corporation with you in future.

Godwin Peter,

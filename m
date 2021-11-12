Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75A7E44EADF
	for <lists+cgroups@lfdr.de>; Fri, 12 Nov 2021 16:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234511AbhKLP5G (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 12 Nov 2021 10:57:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233776AbhKLP5G (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 12 Nov 2021 10:57:06 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73CE8C061766;
        Fri, 12 Nov 2021 07:54:15 -0800 (PST)
Date:   Fri, 12 Nov 2021 16:54:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1636732453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IEtagM4Et8kzeQZy8+ha45gEF5OfK9xqtK0ZgxfSfk0=;
        b=Dv1v8YtnEQ2v4yoUFwWiXbGpLSwLTCXV24SYYjuSlpEpv/i+m2VqXUhXIwl1fbotZmd4Yj
        rWERSANWeJUEYbQfRQd+laM3jy7WtOzTmOwotS/SJF+z1wZMtFp1oiHwrWroXtuDv1j642
        0WwJhZCI6Uq9x5OD9V45VdHzUDBeO8gw2+U1siy82v/tuYqTXy/TYaaLZkCSOn/+KCBXN5
        AsWl8pHHaCMGmWZL3KZFbh1s7gsQpS426+0pX4z3fHI+hu46Vp0aqnk5261e2c6hS0Xnnx
        wCNFRtTY5xWFadrWj0EeggKTeVNyE34oPoZBNQe/wtmXlqrEecBWgauSSqVMOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1636732453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IEtagM4Et8kzeQZy8+ha45gEF5OfK9xqtK0ZgxfSfk0=;
        b=RAHny7lC+VmQLwhjVY/jsQR+litAUWbIQQrdARneRGuLehOqxYGO3iT/KHa4FPeo9GDCDJ
        lPc/ZIHrHwxyaxAw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Jan Kiszka <jan.kiszka@siemens.com>
Cc:     "Moessbauer, Felix (T RDA IOT SES-DE)" <felix.moessbauer@siemens.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "Schild, Henning (T RDA IOT SES-DE)" <henning.schild@siemens.com>,
        "Schmidt, Adriaan (T RDA IOT SES-DE)" <adriaan.schmidt@siemens.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: Questions about replacing isolcpus by cgroup-v2
Message-ID: <20211112155411.gmpwaf5bkgs2i227@linutronix.de>
References: <AM9PR10MB48692A964E3106D11AC0FDEE898D9@AM9PR10MB4869.EURPRD10.PROD.OUTLOOK.COM>
 <20211112153656.qkwyvdmb42ze25iw@linutronix.de>
 <AM9PR10MB4869F9A2D7F5F95C29B5521889959@AM9PR10MB4869.EURPRD10.PROD.OUTLOOK.COM>
 <2587fcb7-6c3f-e44c-ba4b-20e7327337e3@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2587fcb7-6c3f-e44c-ba4b-20e7327337e3@siemens.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2021-11-12 16:46:08 [+0100], Jan Kiszka wrote:
> > https://www.kernel.org/doc/html/latest/admin-guide/kernel-parameters.html
> > isolcpus=       [KNL,SMP,ISOL] Isolate a given set of CPUs from disturbance.
> >                         [Deprecated - use cpusets instead]
> >                         Format: [flag-list,]<cpu-list>
> > 
> 
> That was Frederic himself via b0d40d2b22fe - but already for 4.15...

Just found out that myself after getting the pointer from Felix. Maybe
he is able to answer the questions here :)

> Jan
> 

Sebastian

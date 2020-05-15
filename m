Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58DB21D4CDA
	for <lists+cgroups@lfdr.de>; Fri, 15 May 2020 13:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbgEOLl7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 15 May 2020 07:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbgEOLl6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 15 May 2020 07:41:58 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63635C061A0C;
        Fri, 15 May 2020 04:41:58 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id l3so1914221edq.13;
        Fri, 15 May 2020 04:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=RWK3xRBK3vF039IvGRjdVtIEkl1uwsII0GmOE8enEhg=;
        b=AQ9HX6rwWWp133kyVs2PIJL5t+b/npGe7W2nKwSP00VnDRcm0saijkshcdRXR10VlL
         N3QvsCS9Nf+I1JhMOMiw+s9X5sS4vLhmyuKy3L+93WpWfow7gI05+dOZYGAI5r4cU8y1
         rJx1+S0EECUThKB3RqnhXEQreTT8itZR/odWs96CLWvXaxSos2ymicfJwUvXxUq2Cyaf
         KnRBdDXaLTKwoY3NlxhBOVeOCPlpn00Mf7t+vRbun0vUbFkFWOI+2VVcglalTkwpQD0C
         ktLCP3/1ggat4CkA0bkiK1Ciph/UfOrPoEWagk2/a3RWjWai3Tb1ecqCvmVFj90S59jX
         vAPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=RWK3xRBK3vF039IvGRjdVtIEkl1uwsII0GmOE8enEhg=;
        b=fk+1CluEiGkXyUhm63vK/uOzFStDzAHfwJiWN2c8vHmxtwl8aES4zFsL20rMnMGg1U
         PXVd8djpqY1+Zgc+mCFYjO1Ym9JX/H5jpAv2q24bU2Whuq8kQOIm6ILNkxXEmsD2u5p4
         Fo0ReN7oKxeawUNx4eP4ybWD91xvStXrFlCLLMdHKknt6F9mkRew5xLJZf2SZ+8H8hBW
         eAbpJCZWEmyfyVZ2yVismcmvADWOCF8W8os/k5QGII0ZTLEO1d+e1FwYrn/U8Q78gQmx
         d+ZQ1Wjkx6jmDMLY5r6z5CEckSxD5TDtX1Hat7PDQ25k0lBwS1dh+bAzyEtqVBsr4OxW
         KC7A==
X-Gm-Message-State: AOAM532GYI1BrYj/HjvcXJSg+5qmMxDuTdiCuH0vVmjJ/1hRQOntfCtg
        A0TA7evDuenonPls9fGAR/AfnoDrENFS1pzoGn04lw==
X-Google-Smtp-Source: ABdhPJz1RIomfe7RiC1u7TKWUXwQNw8CcWTmJoSxNcIZssX43Bjmg42p6f/3pmGxPvbz7iDqC86FN17PdfSdI+NU9sg=
X-Received: by 2002:a05:6402:c0f:: with SMTP id co15mr2299648edb.286.1589542917105;
 Fri, 15 May 2020 04:41:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAKgNAkhL0zCj11LS9vfae872YVeRsxdz20sZWuXdi+UjH21=0g@mail.gmail.com>
 <20200410104132.294639-1-christian@brauner.io> <b7550fcd-ba12-e64a-3228-e6668b31a8a7@gmail.com>
 <CAKgNAkhQr+sKGAu+KcxPEsuwG3kjQOyzVW7E1yM9cMtSZrhW9A@mail.gmail.com> <20200423101420.udkmlhnfg57lsshi@wittgenstein>
In-Reply-To: <20200423101420.udkmlhnfg57lsshi@wittgenstein>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Fri, 15 May 2020 13:41:46 +0200
Message-ID: <CAKgNAkhXxWFE8msNkJ3117ChacWsfiMsBptZsVJOnxGtuDTX0Q@mail.gmail.com>
Subject: Re: [PATCH] clone.2: Document CLONE_INTO_CGROUP
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Christian Brauner <christian@brauner.io>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello Christian,

Ping!

Thanks,

Michael

On Thu, 23 Apr 2020 at 12:14, Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> On Tue, Apr 21, 2020 at 04:30:46PM +0200, Michael Kerrisk (man-pages) wrote:
> > Hi Christian,
> >
> > Ping!
>
> Will likely take a few days until I can get around to prepare a second
> version. Sorry for the delay!
>
> Christian



-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/

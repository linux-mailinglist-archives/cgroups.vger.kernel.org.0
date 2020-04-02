Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B18719BA13
	for <lists+cgroups@lfdr.de>; Thu,  2 Apr 2020 04:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732732AbgDBCAg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 Apr 2020 22:00:36 -0400
Received: from mail-qv1-f68.google.com ([209.85.219.68]:35231 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732537AbgDBCAf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 1 Apr 2020 22:00:35 -0400
Received: by mail-qv1-f68.google.com with SMTP id q73so936683qvq.2
        for <cgroups@vger.kernel.org>; Wed, 01 Apr 2020 19:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=qfoLXrnqNbdNMc/qg2fQn2VjZnT5IOOCPmT892IlYdk=;
        b=cKiCEtpAG53uMWAllPIubuUVMZlkf3zGEeenWXGZmNb+BHlxsZBGyKew+FTU9oQ0DK
         McD3eNpxPXKTXQPqLWrgQdam04yznD9HI+ZfpUVD4+6oU/EnkDneahxLSct/AcGOF4gG
         uheCdgHsaoKysYe8jmBDL5RQYET+jwYiCS8TGbjMxhAArzztsmCasWUrhDVQx5cbzEiC
         46MaPsstwXUfybIOU50IHy4Ix+1AtX+LmS7afvx+O+PlAXsZ+jUibdRobmcBTI6f7Jxi
         MgjCUnelx9ep+I9n1ADEJjzAxCwlrKMWRT47dVTrQnjx7fRr/mKa6yMLmmnXJqb/GFsW
         Zg4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=qfoLXrnqNbdNMc/qg2fQn2VjZnT5IOOCPmT892IlYdk=;
        b=qg9i8aeU7RfTEOM6lT+0ezsjQOQZh5hbfBb9CL6bWfSSLCqYLrPuoDAItkxwhLaxN1
         dMoOv5npr1VNXb/YwvGYMJUPXJHx7Sj/OW757nfwq76GrGaapA2SZt5HwhDI6tbjs4ga
         jZK6RjWKTvEuior4L96qFK9GOFx3xMtASlcH4ME63sbELABBMtJQ0b/qOv8GxwjTrj0S
         qZZ4zFuoaO9bii8653qQYXh9L81OAGMvNhErzTc4acAAdYwt1x0YXGV1DdYM1pw/4OFZ
         1S5Kpr8yD2MZTJqhcuyHdsn0TpMf2sxBSZ4voUSQFRikfxG2IxUHtGQ9pGIPlUqJO9j/
         Egug==
X-Gm-Message-State: AGi0PuakvukMVyErHAwxcaVtJxP/IaFvG83gHAZUYMbYTfQAyQpwDtUy
        AGl9ivBZiQkX8JfopvvWZ535Tw==
X-Google-Smtp-Source: APiQypKt76w7m6e5xoRV81SkiAPCm2e1rthecIHWTZSulTpArjqfbhWp7Y/79CYWcsS260luE96bsg==
X-Received: by 2002:a0c:90aa:: with SMTP id p39mr1075930qvp.38.1585792834408;
        Wed, 01 Apr 2020 19:00:34 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id s56sm2889238qtk.9.2020.04.01.19.00.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Apr 2020 19:00:33 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: Deadlock due to "cpuset: Make cpuset hotplug synchronous"
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20200325191922.GM162390@mtj.duckdns.org>
Date:   Wed, 1 Apr 2020 22:00:31 -0400
Cc:     Prateek Sood <prsood@codeaurora.org>,
        Li Zefan <lizefan@huawei.com>, cgroups@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6AD62381-394F-4742-816B-12DE67DE9788@lca.pw>
References: <F0388D99-84D7-453B-9B6B-EEFF0E7BE4CC@lca.pw>
 <20200325191922.GM162390@mtj.duckdns.org>
To:     Tejun Heo <tj@kernel.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



> On Mar 25, 2020, at 3:19 PM, Tejun Heo <tj@kernel.org> wrote:
>=20
> On Wed, Mar 25, 2020 at 03:16:56PM -0400, Qian Cai wrote:
>> The linux-next commit a49e4629b5ed (=E2=80=9Ccpuset: Make cpuset =
hotplug synchronous=E2=80=9D)
>> introduced real deadlocks with CPU hotplug as showed in the lockdep =
splat, since it is
>> now making a relation from cpu_hotplug_lock =E2=80=94> cgroup_mutex.
>=20
> Prateek, can you please take a look? Given that the merge window is =
just around
> the corner, we might have to revert and retry later if it can't be =
resolved
> quickly.

Tejun, can you back off this commit now given it seems nobody is trying =
to rescue it?


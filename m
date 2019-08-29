Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB3DA2B30
	for <lists+cgroups@lfdr.de>; Fri, 30 Aug 2019 01:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfH2Xw7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 29 Aug 2019 19:52:59 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37865 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbfH2Xw6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 29 Aug 2019 19:52:58 -0400
Received: by mail-pf1-f194.google.com with SMTP id y9so3233122pfl.4
        for <cgroups@vger.kernel.org>; Thu, 29 Aug 2019 16:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6oTB1dU146xuL9pK4Gwg180KU60SGC31jIorRGs7ptk=;
        b=a250Zfx3hOfWzOHrL5E2dEv/6jxRZA+JbksFHHqddgm0GXvE1i4OV0Ui/sUUwWq9Qz
         4sKMyiAb+MJUEMoErBcXFPrcnPtDT2GaH8lfEelAqVK5nG8PlK407kkkx6hvjFc6VoV9
         U33PcQmOIjjinVTDjaCccNNDE79eJ2UxQkEfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6oTB1dU146xuL9pK4Gwg180KU60SGC31jIorRGs7ptk=;
        b=cbnrAkQv4yIRNFNXQUnYRft0AV6vP1L2LVUnlW4DgyAUQnj0CmfRVEAFDALq023gOd
         xRmajR/CrjKeH8p2V/wBKVehDrs0OpZ1Q/1n52XzO09zNduheecSDKW0G/MRuwz0fIcz
         zza1a8NwMtpZV1I77yGEEyxCRZG35vtPQBh5kf83wimvC8pGiI6Bmlq7rv4CgnZoSt5J
         KG4lEUgbpJWMjYWji4nxdpk98n0zC2AQH22IJnYPqvz7cQsJ2DEMHADsTXgj9uqq0mkB
         JiDjC6wODCrkfGFUAFZISr2eNainnZD0yiZ5pJEKVty+AVCw5kZTi/ZAzIGipK0kMOn5
         zg6A==
X-Gm-Message-State: APjAAAVogazICsjnXv4E9md8T8OPdHcILExf5LDOkXM6PHSzQivL6rAz
        QEAhOfC2alkEDTpSU2NKk/Fh+Q==
X-Google-Smtp-Source: APXvYqwiOx/qe9a/xRLREIyTn3MhbFX5uD0lqjU79yaf26iwaXo0Rf6U2kBqJTeyMxYK5IrjN8j1aw==
X-Received: by 2002:a62:1a45:: with SMTP id a66mr15134237pfa.142.1567122778338;
        Thu, 29 Aug 2019 16:52:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v189sm4473046pfv.176.2019.08.29.16.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 16:52:57 -0700 (PDT)
Date:   Thu, 29 Aug 2019 16:52:56 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>,
        Laura Abbott <labbott@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 01/12] rdmacg: Replace strncmp with str_has_prefix
Message-ID: <201908291652.46E2D65@keescook>
References: <20190729151346.9280-1-hslester96@gmail.com>
 <201907292117.DA40CA7D@keescook>
 <CANhBUQ3V2A-TBVizVh+eMLSi5Gzw5sMBY7C-0a8=-z15qyQ75w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANhBUQ3V2A-TBVizVh+eMLSi5Gzw5sMBY7C-0a8=-z15qyQ75w@mail.gmail.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jul 30, 2019 at 02:39:40PM +0800, Chuhong Yuan wrote:
> I think with the help of Coccinelle script, all strncmp(str, const, len)
> can be replaced and these problems will be eliminated. :)

Hi! Just pinging this thread again. Any progress on this conversion?

Thanks!

-- 
Kees Cook

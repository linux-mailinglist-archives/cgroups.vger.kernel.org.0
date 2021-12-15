Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1374760B7
	for <lists+cgroups@lfdr.de>; Wed, 15 Dec 2021 19:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343788AbhLOS2U (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 15 Dec 2021 13:28:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbhLOS2Q (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 15 Dec 2021 13:28:16 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9132EC061574;
        Wed, 15 Dec 2021 10:28:16 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id g19so21441765pfb.8;
        Wed, 15 Dec 2021 10:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ljp+r2/uwwJFUdX/+JTcBmL6u7/IlJQzL4z/nVQyjLQ=;
        b=DMRQ5tYS8xfdjkB/0Bu6POtAC9xPB3oOWHQ3zp+tyyxHvPYs/QTZTi3zPJX4A6Y5F3
         nGEdDCNDIi88nqZqirGia2JnkFbUNdlY3RGfvIBjp9s6OD2sYnPeP4Q7r5Wed7PJZ0Y3
         +AMiAEx2pHtnQ/86Qy4BtgxnoumB1K+ZkR+Ym9t5p0kW4ZzIe2uRaD9LdVAlS8XcMKOW
         Ll37jAXwZgET3DQMqrmd6+YoemVFMwBYKaoP467YQ5LUTNKJxMRyFqPsqRwjbXsNw1aN
         txz/TDUtfF4BADU1sWh7PR9Gc3AvMFIeHeTVSpfp3mDwV7xLtbDNTUMwKHEkl9hBRrb+
         TYag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ljp+r2/uwwJFUdX/+JTcBmL6u7/IlJQzL4z/nVQyjLQ=;
        b=HoRZfAN3eb6iWpuolTunvpyvTSDGHs2L52VntpN67flwLTSudxPKa/XviOoMLqEQlB
         3YNNj+JBMsotAYJC7YluqfnJuIB1hpty6AQ812eZNPeGUAJbfgVqL/5yTsvGHSIQRI4B
         8U0d+XiOn7RFq91Max9I2xgaE8GjFCLce5nzCV3Z1bIGgM92hOKAVunHJIB+MfUH27sk
         W9JrLKDOcCVj/5mMP/IkUuKtfFOkadFiZcgz4nMYNBST08dFZv9HNAGMenwfaroFQwvx
         xHj7Nud4iMf6szV5XtZfrsp1TvVPr7mjMLZrl4diVw6ZHIHuF06ND/wgSel9178WkMvs
         Eyxg==
X-Gm-Message-State: AOAM533YSPdON91sTU5E0Zx9J4YBVQ60NW/i4U0kTAmQC7HBrJ5/pgoS
        +JvGfWgAMawy5at0JwhQWq4=
X-Google-Smtp-Source: ABdhPJx8gJqM3Sl9c9Tcn5jfoWFOx30/5A2bh9SJMye4DepATryrjx2PnUq/V3OU+0j6rSODVlG8Fg==
X-Received: by 2002:a62:1614:0:b0:4a2:fa59:c1ad with SMTP id 20-20020a621614000000b004a2fa59c1admr10090808pfw.80.1639592895935;
        Wed, 15 Dec 2021 10:28:15 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id np1sm7404824pjb.22.2021.12.15.10.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 10:28:15 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 15 Dec 2021 08:28:14 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     daniel@iogearbox.net, ast@kernel.org, andrii@kernel.org,
        bpf@vger.kernel.org, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, rostedt@goodmis.org,
        mingo@redhat.com, yoshfuji@linux-ipv6.org, dsahern@kernel.org,
        jmorris@namei.org, serge@hallyn.com, cgroups@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH bpf-next v4 2/3] add missing bpf-cgroup.h includes
Message-ID: <YbozvuaPMu58RqU2@slm.duckdns.org>
References: <20211215181231.1053479-1-kuba@kernel.org>
 <20211215181231.1053479-3-kuba@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215181231.1053479-3-kuba@kernel.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Dec 15, 2021 at 10:12:30AM -0800, Jakub Kicinski wrote:
> We're about to break the cgroup-defs.h -> bpf-cgroup.h dependency,
> make sure those who actually need more than the definition of
> struct cgroup_bpf include bpf-cgroup.h explicitly.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

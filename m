Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF71179589
	for <lists+cgroups@lfdr.de>; Wed,  4 Mar 2020 17:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729811AbgCDQmI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Mar 2020 11:42:08 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45215 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729762AbgCDQmI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Mar 2020 11:42:08 -0500
Received: by mail-qk1-f193.google.com with SMTP id z12so2227231qkg.12
        for <cgroups@vger.kernel.org>; Wed, 04 Mar 2020 08:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0xLBL5fJTc5AsUQPy+WSwVwS7vBKnygmPmF5kHtg+Ko=;
        b=JphAytlDLBqcavrEVXy4D+clSdLG2pVQ4Y2FDvGxgP1eYafwN2BgQyrmHd/m1j2EMy
         XoEpWt39eUtxargjw6ERdE8tFwlleRpoM6V+skpSS4BGl1/6SLlj1SsCqwFjXCuhLkOc
         6Qbk+dx1Mn5nqQNwgcVNUTF662gbRJqeXMwEtgLE/rr+AqJWKyGVunibVo0v0VFjWGuY
         l2WjaUuHbgVEbtKZlJFPCixJXAKkVg9LDKA6uICAsFSvQwrw6mxT60AsjL2lBgm9Fqn0
         bVOK3H/IhhzfnFZ79b1uD8SJsUFzpuLHdwJWmU5gVyIJstRv3OIZfKslcZpafLFQVdKB
         mBtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=0xLBL5fJTc5AsUQPy+WSwVwS7vBKnygmPmF5kHtg+Ko=;
        b=AZOmwEW51lLu0KaTP3jVD4nuQPDglzi/pKESKg7OlxfmP8vieQwLoubodwoSWOG6Jk
         wtd3pU2cXOq1+fqZsbT/N0XAi9PFipIy3Pg5uprG4G5LhG5LqmLje8F9L9xN2hr/L7rb
         arqNaadv7EUzXf5riWysUfNfA1xNwJCaKuyW2dyG++YP7dOqPYo3DYB/p4/j9T4+OHcS
         dOXSMPLR5JdkmyjMvJ6E+D3zeQYWH5kvp20oviZAULD+qAqirCVQEIni5xa73A0ZF08X
         rYksxzhVJgAHxIYcm2boikwVgOZZCk+GrInwNkpGJV4jGJfAPRaVJ5j+i5yX76v9px1N
         rAgg==
X-Gm-Message-State: ANhLgQ0r3Fa5aVQZ7VCvG4aer2OXHMOq6LpKm+uSZRdl57ctsosGTv2F
        GKOVNsPU0zsy53lYtdvFC4Y=
X-Google-Smtp-Source: ADFU+vuuP42wsq5zNvjSD/o3x2JeeThSpEUCJYY72NhISUzYwpkrFwZm38Ui/kbiGobZZSWCVUwB0g==
X-Received: by 2002:a05:620a:15b3:: with SMTP id f19mr3602310qkk.15.1583340126981;
        Wed, 04 Mar 2020 08:42:06 -0800 (PST)
Received: from localhost ([71.172.127.161])
        by smtp.gmail.com with ESMTPSA id t6sm14177750qke.57.2020.03.04.08.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 08:42:06 -0800 (PST)
Date:   Wed, 4 Mar 2020 11:42:05 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Benjamin Berg <benjamin@sipsolutions.net>
Cc:     cgroups@vger.kernel.org
Subject: Re: [BUG] NULL pointer de-ref when setting io.cost.qos on LUKS
 devices
Message-ID: <20200304164205.GH189690@mtj.thefacebook.com>
References: <1dbdcbb0c8db70a08aac467311a80abcf7779575.camel@sipsolutions.net>
 <20200303141902.GB189690@mtj.thefacebook.com>
 <24bd31cdaa3ea945908bc11cea05d6aae6929240.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24bd31cdaa3ea945908bc11cea05d6aae6929240.camel@sipsolutions.net>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello, Benjamin.

On Tue, Mar 03, 2020 at 03:40:38PM +0100, Benjamin Berg wrote:
> I believe systemd tries to resolve to /dev/sda but that seems to fail
> for me. So I think there is a bug in that code; I'll verify that and
> submit a fix if so.
> 
> Which device should actually be selected? Is it /dev/sda or the mapper
> device that / is mounted from?

Right now, the situation isn't great with dm. When pagecache
writebacks go through dm, in some cases including dm-crypt, the cgroup
ownership information is completely lost and all writes end up being
issued as the root cgroup, so it breaks down when dm is in use.

In the longer term, what we wanna do is controlling at physical
devices (sda here) and then updating dm so that it can maintain and
propagate the ownership correctly but we aren't there yet.

Thanks.

-- 
tejun

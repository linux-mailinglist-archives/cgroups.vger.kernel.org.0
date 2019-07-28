Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B196781E1
	for <lists+cgroups@lfdr.de>; Sun, 28 Jul 2019 23:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbfG1VjO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 28 Jul 2019 17:39:14 -0400
Received: from mail-qt1-f175.google.com ([209.85.160.175]:40840 "EHLO
        mail-qt1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbfG1VjO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 28 Jul 2019 17:39:14 -0400
Received: by mail-qt1-f175.google.com with SMTP id a15so57744305qtn.7
        for <cgroups@vger.kernel.org>; Sun, 28 Jul 2019 14:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YH3/wT+cTox718QKlVPN3VNrRnEKlV12MOV4OX51RgA=;
        b=jrIqJ7geMyt3Nn8m5sFlBvbgaeBpqJVm/l/SZW/WXi7dKuP4muj9HCQXHz0jTivXkC
         I1/Qhwlgs8XqOOPoGoydOnL+OEe3jLrq2tRARU7Ff0lqKM5TpSfaDVH4caKeObGi+8vy
         MefyjADc2LUvA7Oz+bpIXhocppf1jILL63CX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YH3/wT+cTox718QKlVPN3VNrRnEKlV12MOV4OX51RgA=;
        b=APKYOk2wPazfUAaMByyrdezh9HmlnGa6iXRXjFitbgp2HDqW02jG6qUnpY+lMF0PV0
         P4YPZQxAbTw+6+K3yaSvgxOEN79uFXmDf2pQE2BonIL4xLrp26gt4fj4L44cQMtUSLx9
         BBfkTrLKyAHnc5M2prxfQh/D7Rjj+FXUl36jEt9XsFbKXWE8qE/KssUajhy4XdL4JBi0
         1fzfFBpVFD+xRYUhtxcONF5KTK3XmqyVD5z861aR9NWENXu/pv/GlVhrlgApcEQ37za1
         sc9xFnNKRLe/ifDpik7s8uHrsKgbjGSpVmRm/RvWCGcN+NIVzf1lZbD9JCSXZExPoFVi
         WJ1w==
X-Gm-Message-State: APjAAAUiwwBgkF0Lxf3yU/+aKN05r645RlNcnNIzxmpJ6aQAxKAXDjij
        cAz42evVk0RjcFsgJNHs74rcZw==
X-Google-Smtp-Source: APXvYqyVT2VgEEMPpkMQCCj5rnFGVpkZLpAQ3yGYm3a86qXec/2goBgdvj52z3louGSZGggDKZwKrQ==
X-Received: by 2002:a0c:e5c6:: with SMTP id u6mr58990963qvm.102.1564349953210;
        Sun, 28 Jul 2019 14:39:13 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::53b0])
        by smtp.gmail.com with ESMTPSA id t29sm23521011qtt.42.2019.07.28.14.39.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 28 Jul 2019 14:39:12 -0700 (PDT)
Date:   Sun, 28 Jul 2019 22:39:10 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc:     Michal Hocko <mhocko@kernel.org>, cgroups@vger.kernel.org,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "n.fahldieck@profihost.ag" <n.fahldieck@profihost.ag>,
        Daniel Aberger - Profihost AG <d.aberger@profihost.ag>,
        p.kramme@profihost.ag
Subject: Re: No memory reclaim while reaching MemoryHigh
Message-ID: <20190728213910.GA138427@chrisdown.name>
References: <496dd106-abdd-3fca-06ad-ff7abaf41475@profihost.ag>
 <20190725140117.GC3582@dhcp22.suse.cz>
 <028ff462-b547-b9a5-bdb0-e0de3a884afd@profihost.ag>
 <20190726074557.GF6142@dhcp22.suse.cz>
 <d205c7a1-30c4-e26c-7e9c-debc431b5ada@profihost.ag>
 <9eb7d70a-40b1-b452-a0cf-24418fa6254c@profihost.ag>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <9eb7d70a-40b1-b452-a0cf-24418fa6254c@profihost.ag>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Stefan,

Stefan Priebe - Profihost AG writes:
>anon 8113229824

You mention this problem happens if you set memory.high to 6.5G, however in 
steady state your application is 8G. What makes you think it (both its RSS and 
other shared resources like the page cache and other shared resources) can 
compress to 6.5G without memory thrashing?

I expect you're just setting memory.high so low that we end up having to 
constantly thrash the disk due to reclaim, from the evidence you presented.

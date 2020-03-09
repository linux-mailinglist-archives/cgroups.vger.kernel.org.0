Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2BDA17E9AC
	for <lists+cgroups@lfdr.de>; Mon,  9 Mar 2020 21:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgCIUFi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 9 Mar 2020 16:05:38 -0400
Received: from mail-qv1-f68.google.com ([209.85.219.68]:45317 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbgCIUFi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 9 Mar 2020 16:05:38 -0400
Received: by mail-qv1-f68.google.com with SMTP id du17so4407562qvb.12;
        Mon, 09 Mar 2020 13:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+ZjW9cfDpa/bATgR4gQIdFs9uH7Dsn2IXM1Pc8dEvAU=;
        b=Jl5GP4mafSZXODnON2fziI+zRq75X3kZPaB00uliiygLfB+5WbqPjzKgph4Taznw+F
         El6NAvSi9cgaXMa70CWtVT6bzlSKRFYEWOqw1KD9r4khD3tNh2kjs1jW/67LEeS2Kd3P
         wp7d9Pyj5Z8ESZLUcDLqZ1dB9LELTPTC7Zv7hrFWiCsxu/mVToq8pTVPLa9bJx5Jx6ZT
         BJrINld4wiMNzV3pbhwgcl5OnzQJvyI0b3iUiUl7Hcq900ZzQ635ANXTUo6t55i0dVc1
         EcKWNkBKANRaCHXbD41dacsGCSusl4myYtRNnZrDFFCDtT20rkXucetpXPMD/4NJrkHy
         Trww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=+ZjW9cfDpa/bATgR4gQIdFs9uH7Dsn2IXM1Pc8dEvAU=;
        b=Wkhlaf3CNSkPm/FHele/Z29dTeGb4QhRiEiHI8IZZmNIzSTtG6A3ZaS2iH83W4z+PJ
         xNBJN2CxO/LivR9uai/bWcASauxrL4qShZKLEdqdZLO5NKnr2cZbbGsWhMy4SIjiE8sg
         BrdzdyKePqrYkUEtlVgtyWth/ynlHqqIHuntjWReG4jeOwYT7MJSucSYRKNvlwIqvS3D
         4efkztvlAtLBCPhzT1Y2gCPomyjxFMBDsshzvkE1wYJayD6oddmJFSywxzvTP6KTYEPb
         bqpHkPUvgyX2+EfO5gBbG1hJiprptz9x5XVgbfauI4zGP5kJegUZ6k7ApKbE1i4CDhR3
         ky/g==
X-Gm-Message-State: ANhLgQ0RxnclkWZK9nQhyq6TaJ8Z0AOp0SD8NMruNN9m/idPW5C4gnsR
        Pevo6t3VfXU0Ecm+3Dg7FRU=
X-Google-Smtp-Source: ADFU+vuN3NVu9VJSb5ZE+9k6NR0Pu+aOSiopLLM82qWJxwelhUJ9LL6sbw1/V0dXcFFDEjrDm6J1Uw==
X-Received: by 2002:a0c:f905:: with SMTP id v5mr15442081qvn.174.1583784336439;
        Mon, 09 Mar 2020 13:05:36 -0700 (PDT)
Received: from localhost ([71.172.127.161])
        by smtp.gmail.com with ESMTPSA id w204sm10323488qkb.133.2020.03.09.13.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 13:05:35 -0700 (PDT)
Date:   Mon, 9 Mar 2020 16:05:34 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     Daniel Xu <dxu@dxuuu.xyz>, cgroups@vger.kernel.org,
        lizefan@huawei.com, hannes@cmpxchg.org, shakeelb@google.com,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        kernel-team@fb.com
Subject: Re: [PATCH v2 1/4] kernfs: kvmalloc xattr value instead of kmalloc
Message-ID: <20200309200534.GA79873@mtj.duckdns.org>
References: <C16IH7NEXW4J.440OGTNY7CWX@dlxu-fedora-R90QNFJV>
 <6bbfc8b8c9c206d80de43a64bfe4b8083cc2c02f.camel@perches.com>
 <20200309195104.GA77841@mtj.thefacebook.com>
 <84ef5548ee27e7150d0b7a5702ce50536cea975a.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84ef5548ee27e7150d0b7a5702ce50536cea975a.camel@perches.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Mar 09, 2020 at 12:58:49PM -0700, Joe Perches wrote:
> This feels like driving spikes into a living thing
> more than into a
> corpse.
> 
> I've still got more than a few 32-bit devices around.

Unless you're suggesting we stop using vmallocs altogether, I don't
see how your objection makes sense here.

-- 
tejun

Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41942CE49B
	for <lists+cgroups@lfdr.de>; Mon,  7 Oct 2019 16:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbfJGOEk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 7 Oct 2019 10:04:40 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40283 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727685AbfJGOEk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 7 Oct 2019 10:04:40 -0400
Received: by mail-qt1-f196.google.com with SMTP id m61so8193388qte.7;
        Mon, 07 Oct 2019 07:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mpNfxUl1mCUdiXjigudrtwHaG1qAsCzBGZZW+s8y3Fo=;
        b=Um7Uzaoy6WSIMMNIRXztMQowXtuRFa7RULiv7B9t5bBMGNXcozcvndCrdDyXlOfiPZ
         Lq0/fy/VmhNyhoH8BCKnypBZ9GOl99U+VqFX4quLcIYC4A7UfXN7mJ+pQMgphzZ1QYrf
         A/n3W1h5crEuesmUr9jYQI3o9hXR3So2qOBxqrINQ6fMNRHiu3yzeTePxIBzBYG85aPR
         13AUWabvuF7GX2ePud2dCkGuJ9eyq4PBNikP2XbLEwE/o2gQHCK1pn2lPIxnlnAa+aR/
         1J/kuQnVSnRHCp/SYbYipfo5WDD9cKYEKq/tqOGNoWBdpADyvE5Lqi7i26hK9O9eB2lo
         ikqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=mpNfxUl1mCUdiXjigudrtwHaG1qAsCzBGZZW+s8y3Fo=;
        b=ZyOJsuKEPQvInWWZ7x1MZbah2nmE91cI8IvTCg2OJQyVBArSQgGkIRkiDruiKhYFsW
         nPzGPozLQgsxVhg9i8Csxd9jBaH97yqN8thE/fxNsNZLivSW08/HoA6IzHNmjr1vCUFf
         1IiNQFgQbASeCt7R9siwJikAdyXIrLrdgpY2JymzCRrtfr1s+YQ6nIje4b5NKPqjkFtC
         rIz1koz0zDZvvRKm8r+7L+nB083mMEni79LgoQAuB5fEDhCbselW53mJaMNEwTGMkllv
         OfNZMuR6m28Pfp3AodbOmEqHuV6P4GqtfW4APgkXWHjt7DjNX6gYvI/Cj7wIXcvDkRmT
         sIjQ==
X-Gm-Message-State: APjAAAUCsqSI4EBmHRqwbXHyloGsG3qJjUwOD8oh062CLRT3VB8C+qtY
        hrngX1vjtWae5G+A+bXdsOc=
X-Google-Smtp-Source: APXvYqwPO+Nc3byElLX/MFKjYwBl57P51x05qK0mMVXxCG/r46I05iaMlsMB1rYASu4whzW/6iX9yQ==
X-Received: by 2002:a0c:eb10:: with SMTP id j16mr26693246qvp.207.1570457077309;
        Mon, 07 Oct 2019 07:04:37 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:a536])
        by smtp.gmail.com with ESMTPSA id d69sm7580319qkc.87.2019.10.07.07.04.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2019 07:04:36 -0700 (PDT)
Date:   Mon, 7 Oct 2019 07:04:33 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     lizefan@huawei.com, hannes@cmpxchg.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingfangsen@huawei.com
Subject: Re: [PATCH] cgroup: short-circuit current_cgns_cgroup_from_root() on
 the default hierarchy
Message-ID: <20191007140433.GC3404308@devbig004.ftw2.facebook.com>
References: <20190929080658.11430-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190929080658.11430-1-linmiaohe@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun, Sep 29, 2019 at 04:06:58PM +0800, Miaohe Lin wrote:
> Like commit 13d82fb77abb ("cgroup: short-circuit cset_cgroup_from_root() on
> the default hierarchy"), short-circuit current_cgns_cgroup_from_root() on
> the default hierarchy.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Applied to cgroup/for-5.5.

Thanks.

-- 
tejun

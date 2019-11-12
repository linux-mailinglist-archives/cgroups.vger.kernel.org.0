Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F995F956E
	for <lists+cgroups@lfdr.de>; Tue, 12 Nov 2019 17:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfKLQTI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 12 Nov 2019 11:19:08 -0500
Received: from mail-qk1-f181.google.com ([209.85.222.181]:39943 "EHLO
        mail-qk1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfKLQTI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 12 Nov 2019 11:19:08 -0500
Received: by mail-qk1-f181.google.com with SMTP id z16so14944892qkg.7;
        Tue, 12 Nov 2019 08:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CMydOXW3N0vSyHbPvuoqtInLO7hobFi83yAhmqo2dU4=;
        b=eAf+z0Rpeb2fieTOr8xgddn2osixFXBizD7/0a4W3L/UfN7U8sWKNJ1PGPtsaTilMA
         0/sd00Ca9nAwpl04nkEJG1ALQSb9jG4/QCamaF6n/6xuuKSU+wRPRaCmQhkkONUYpc8A
         FOubWXDBw/B0lyDlszjLb87CmvCt7hbbnzPBHWC0iZ1RZIOWkGtPwaAkpbHquY6O9iVg
         oy7s+fWarNxd20YJUlJO0ntB96qExasMYCOi/+nPNjTjYyXaWMo1aujU4KQyGgqJ9dL0
         EpSZz4ViHjokFwbycLhOoxuapulAd11oe+vyzVX+hYZUN05BzySNyf7eKOKhk2MTHjdS
         kPRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=CMydOXW3N0vSyHbPvuoqtInLO7hobFi83yAhmqo2dU4=;
        b=Yvxtz9n127gLf0MC8hHqkg2PUlw0ngDPCrj2w+52fqzDVNjbtqlY87lfTlmjLXtlS0
         JFzbmPccGGat49cxKWeSLuBwEZNJDf4E3gasv6XYQW8RZQqqO+KMRiqQ+l4VTPtygJiv
         AGVenO2rBdBRnfgdrL7kOeA1z+kDWu6TZUYdVmMwOs00GJYVpcC5jxq2xr6yuyKI2OrF
         6yXrY9skukdoqdOx3pAQNnAA4NyDObrzK0kOgq+izoy3+9icXUKIvWlBvXe31hjNp0wd
         1OAJCuBRMa54V3jxMoxySLYTaPTXWV5kchZDZes4+3LZkSGfOYNgi9AVkfvgW8J+SelN
         zAUw==
X-Gm-Message-State: APjAAAXkqhoIyq6+tpoiEBtzqEICZ8g/1YEi/IVDxEUee7cKUDvWXSGP
        sK2O7AIYeuKvC9iBQ5MLsJw=
X-Google-Smtp-Source: APXvYqzTvSExrmEjeloHMt+L+oxHu4YRZFIzP+D7wbsPvwjBw37J0TGpL53zrBUm/xtA/paQ+FD/mg==
X-Received: by 2002:a37:9bc2:: with SMTP id d185mr15407304qke.299.1573575546164;
        Tue, 12 Nov 2019 08:19:06 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::3:f36a])
        by smtp.gmail.com with ESMTPSA id i10sm8531153qtj.19.2019.11.12.08.19.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Nov 2019 08:19:05 -0800 (PST)
Date:   Tue, 12 Nov 2019 08:19:02 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     kernel-team@fb.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, lizefan@huawei.com, hannes@cmpxchg.org,
        namhyung@kernel.org, ast@kernel.org, daniel@iogearbox.net
Subject: Re: [PATCHSET cgroup/for-5.5] kernfs,cgroup: support 64bit inos and
 unify cgroup IDs
Message-ID: <20191112161902.GG4163745@devbig004.ftw2.facebook.com>
References: <20191104235944.3470866-1-tj@kernel.org>
 <20191112160933.GA1690816@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112160933.GA1690816@kroah.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello, Greg.

On Tue, Nov 12, 2019 at 05:09:33PM +0100, Greg KH wrote:
> Sorry for the delay.  Feel free to take all of these through your tree,
> that probably is easiest:
> 
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thanks a lot for the review!  Applying 1-10 to cgroup/for-5.5.

-- 
tejun

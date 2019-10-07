Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF32CE4D1
	for <lists+cgroups@lfdr.de>; Mon,  7 Oct 2019 16:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbfJGOM2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 7 Oct 2019 10:12:28 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37476 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbfJGOM1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 7 Oct 2019 10:12:27 -0400
Received: by mail-qt1-f194.google.com with SMTP id e15so4444294qtr.4;
        Mon, 07 Oct 2019 07:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=PJgpiGwK2u8oGo+/mbFwzQEWjjSrhtsq1rT3sToNXug=;
        b=D3EPjAtHnXMj06oi4eFAESMOwlvhVr1brLGRpLfMw3+ot0vTbafp3rijEo/vvXOHKw
         +U+I2Hk8Xv50JgEYWP5pi/6IaHdw/2NxvBdBbt5UOu9GDay5d01B6eNobiwqKgRq16ZX
         yp/F2nHltzuMp1iDStX+sTlD/mtz+REv6t8jnMZhDRvyrTUd6KvD0t4UJaUEt8z72+Oc
         9dAZsozshBuhPj3MaI6l+tJZrVAsVw4S/HYF4Dc9bVRDW7lMorMffRtRBNgnyrBQC8XR
         j8/UB1qKysjRxb4ep6pE6FUAP4Yf146BcIX+PX03d7LaMAGxHxJRfaskU4nWftebkEZk
         GPHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=PJgpiGwK2u8oGo+/mbFwzQEWjjSrhtsq1rT3sToNXug=;
        b=c6f4VNuaj0xCV5qQGwjwb3l62LqXlEkQHPPyh7RBh1KCe8vPZ3Fb0LB19YRkS/b5k/
         6qaJ7t06KP66XGtR2ahajmObMfoqYZXUmfkLNkK8L7T6aGZZXo3ghqT+QKWu9T2vBubB
         vXRaIDeZVwcsbK4dZa+8wSM/nAFY3XIUewm7iqF9wyrDfgPQBqytICGYUTluKJjOAV6l
         6VoeHOeC2YPrzzuZ/6O4LivVFgF2IzhLYItHINYzuwq/v6uUOktfqp+FluU1k7kOJUFc
         ABKYHwXwpfVgNN+rk8lgvMcsxh8/9dRL49SRU7RnsYNIks5N1r/aEtLbRwrJkrB/gDFI
         VVxQ==
X-Gm-Message-State: APjAAAUrQ41EWrTlkINZHawnKkc3UZdG04MyPmtG9ofizAsSdDAjO/se
        MoxE2YCEntDXXzdE2cO73z4=
X-Google-Smtp-Source: APXvYqxR7Yg87n3v/5vSn/Ca99fLLepq2rMzrW0vC/GXY5GmAZ4bdqWcQ6/bkP8hzVX9xBz5jaWe+w==
X-Received: by 2002:ac8:2d2c:: with SMTP id n41mr29962785qta.335.1570457546226;
        Mon, 07 Oct 2019 07:12:26 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:a536])
        by smtp.gmail.com with ESMTPSA id x33sm7764954qtd.79.2019.10.07.07.12.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2019 07:12:25 -0700 (PDT)
Date:   Mon, 7 Oct 2019 07:12:24 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH 0/5] Optimize single thread migration
Message-ID: <20191007141224.GD3404308@devbig004.ftw2.facebook.com>
References: <20191004105743.363-1-mkoutny@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191004105743.363-1-mkoutny@suse.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Oct 04, 2019 at 12:57:38PM +0200, Michal Koutný wrote:
> Hello.
> 
> The important part is the patch 02 where the reasoning is.
> 
> The rest is mostly auxiliar and split out into separate commits for
> better readability.
> 
> The patches are based on v5.3. 

This is great.  Applied to the series to cgroup/for-5.5

Thanks!

-- 
tejun

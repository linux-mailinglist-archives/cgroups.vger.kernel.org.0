Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31A6F15B2A5
	for <lists+cgroups@lfdr.de>; Wed, 12 Feb 2020 22:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbgBLVSg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 12 Feb 2020 16:18:36 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40555 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727548AbgBLVSg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 12 Feb 2020 16:18:36 -0500
Received: by mail-qk1-f196.google.com with SMTP id b7so3573971qkl.7;
        Wed, 12 Feb 2020 13:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=31Bj/38A/miaqKjQ58NWeMSoyVnEc1IA1pOEeW3/4nw=;
        b=se4ZxKttnmJxS0lSBYkjbIQ+INqZmThMGsXTtfEn4e2uCBdd7rJ/EyTMKVuXO1FSGg
         0CNxDUOhb1WNHlOIFR9LPNUVRZGiR+THOt7o3DpRgvM9AqFvLVp7XIkha5fMN/NPgMJN
         6VNJkiCSz6Wc/8awOwnb9zcux4XTt89eUmyxtt6yZE8Hy9oWjn5FchInQTyVUhP8I4ho
         g2V2OC2kOR7VvZCH8VF1oD4m5Twj5iNpjNMx/1/IGBrRu6nMINVbbCNvPRRoAdtQy46w
         xqGASdvr2OaiPE4NOmdwBDQ4Gd8UCS3JS3t5x1l5FE9OhWX6hZ7gUOG5GAvGWaZSIV9F
         iMcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=31Bj/38A/miaqKjQ58NWeMSoyVnEc1IA1pOEeW3/4nw=;
        b=sJ6Qxv841Xc/ezHB0rVeg5+IRe0Yolwr/wrbDrkInBbOCW1XiGW+vwvJG3VIy8R057
         OWabdfap+WuNeqYwzqK6DLCIRRO+mN1WndxDBbHCZ/lcKvkyLYo/PRf//DkP6bjmZg+P
         3MSCOlHi45aghH/h6hki0k132kD13vzcyAURdkNTqkm2ia/ugQtiZWTVjm683egduh4R
         lDlKvmzPZQYSdArBtE5gtPGift5fqLZGHhZSDor4lMZA9rGIuLJp0zgvB/3h97sfzl4n
         5kkoyP0svXoz/op0rY85Bj4nCR3drr6p7HsWvGvh/XZu49oB9mXf1rWH1A1YILMVe+co
         vB3Q==
X-Gm-Message-State: APjAAAX5BEmtRO4Fk5DXC/LqDIsNiKBLIsJw9h0zkesqbTTWd44mgrGp
        v10pPbw1+Rnf0RRWMScP6XA=
X-Google-Smtp-Source: APXvYqxCRJg9R74eWw90LZJfPcepMliFU2haQ1cK96y444a9nBXcJpYBmFzN8l9ubEf4J91p9xKoSQ==
X-Received: by 2002:a37:2c41:: with SMTP id s62mr12410731qkh.433.1581542314890;
        Wed, 12 Feb 2020 13:18:34 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::1:985a])
        by smtp.gmail.com with ESMTPSA id z34sm210214qtd.42.2020.02.12.13.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 13:18:33 -0800 (PST)
Date:   Wed, 12 Feb 2020 16:18:32 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Prateek Sood <prsood@codeaurora.org>
Cc:     peterz@infradead.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpuset: Make cpuset hotplug synchronous
Message-ID: <20200212211832.GC80993@mtj.thefacebook.com>
References: <1579878449-10164-1-git-send-email-prsood@codeaurora.org>
 <ee889f30-cb81-e0a8-6068-715ca3399fdd@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee889f30-cb81-e0a8-6068-715ca3399fdd@codeaurora.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Feb 01, 2020 at 08:33:34AM +0530, Prateek Sood wrote:
> Hi Tejun & Peter,
> 
> Could you please share your feedback on this patch for making
> 
> cpuset_hotplug_workfn synchronous.

Hey, IIRC, we went back forth with this several times. Unless there's
a pressing reason to change, I'd rather leave it alone.

Thanks.

-- 
tejun

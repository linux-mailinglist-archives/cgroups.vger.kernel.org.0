Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93DB015064
	for <lists+cgroups@lfdr.de>; Mon,  6 May 2019 17:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbfEFPic (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 6 May 2019 11:38:32 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45431 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfEFPic (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 6 May 2019 11:38:32 -0400
Received: by mail-qk1-f193.google.com with SMTP id j1so2242677qkk.12
        for <cgroups@vger.kernel.org>; Mon, 06 May 2019 08:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VIOlUbG7Sec/YsnU/8uyYC3t16bFfoMRGadcEW4GAP4=;
        b=OofB7eDonh3dHTGpLy349FrG9pCHvJjJ4wiMRvqmMyKYrNO9FUfLLPuADIpylNftCA
         UqV60tOeqbAk60VwKitciZyBCYeW0N/RaHVuaJgjVcx4quby2AS1UA60pOO+UH/6jv/f
         rqaN3IYTlgcVXsBI0jr9hBRkjBDktLzpH6kr5jHBtDY6e7ZwqnyCbvoyGG1+ewpn6Gm0
         IFS23kGmdvxBrwfn5FoAXaROoHLRLOO7ged6U4u+s11EwZRYEKhqNnP0LV3FUoE5l5iA
         B5+kRMSk7uINwUPVpQ59a05WB5fE7bll/aSWaG0Gl8ONCuvjNrMXLq8CnBEWwvS74S/2
         Dskw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=VIOlUbG7Sec/YsnU/8uyYC3t16bFfoMRGadcEW4GAP4=;
        b=p51m6rMH4VXvmQWWtktw4id3yZVFo0e8Vi44rVabl8zOQUUWJBRQQorM3KXpU2B4v8
         kZWtXbZJM3o7SfqsfcA8YMWCJY2avsWxZVqtk1dBIWN26vneMnwpSgDtV9b0+aCo3N2Y
         g182+De3uBFspngvfEzv7ubalvvo1XWiMTVSj4RSWnR1yjEJ/3TIOb6pa9jfTzimTOLb
         kURfoPnsp/yl0i2j1SueCfT5tQ7Ow2c0Y7i1AAjyqFc1PJxXU1JrEWdAV9X0McB9rkUv
         1b9iXPuZuOCOzVJ4EDdzAcLxpanZGCD6D8aCilC63mqTVomlQz6dgpJypGfKGu3QgEb5
         1Tow==
X-Gm-Message-State: APjAAAW/xthEK83KRc4Ij+KY6c7sZFxmofEOPkOKdSF+LEN7/LfPZ+Pt
        PO/DD0V9dx7dxnveBlme1ro=
X-Google-Smtp-Source: APXvYqw/ccIHcG+UYU+nRpHwsSyOweIZtXwu6ACedgDTfJ8QFP4blVc4emgXhmcelM06DzCIOLUO2Q==
X-Received: by 2002:a05:620a:12e2:: with SMTP id f2mr20431496qkl.214.1557157111595;
        Mon, 06 May 2019 08:38:31 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:34f3])
        by smtp.gmail.com with ESMTPSA id x65sm6062796qke.58.2019.05.06.08.38.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 08:38:30 -0700 (PDT)
Date:   Mon, 6 May 2019 08:38:29 -0700
From:   Tejun Heo <tj@kernel.org>
To:     muneendra kumar <muneendra737@gmail.com>
Cc:     cgroups@vger.kernel.org
Subject: Re: Is there a way to print cgroup id from user space
Message-ID: <20190506153829.GO374014@devbig004.ftw2.facebook.com>
References: <CAAhcyz=HefHnfg9jhz3W15OBgorodVXEkBR7zP_K6Xh-Mr19dA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhcyz=HefHnfg9jhz3W15OBgorodVXEkBR7zP_K6Xh-Mr19dA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Apr 29, 2019 at 11:01:49AM +0530, muneendra kumar wrote:
> Hi ,
>  I need to print the cgroup id info of all the cgroup that have been
> created on the host.
> Is there any utility to print the same.
> 
> struct cgroup {
>    .......
> int id;  ==> wants to print this id  info.
> ...
> }

drgn? https://github.com/osandov/drgn

-- 
tejun

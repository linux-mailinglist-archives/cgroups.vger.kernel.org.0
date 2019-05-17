Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6F921C02
	for <lists+cgroups@lfdr.de>; Fri, 17 May 2019 18:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfEQQtn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 17 May 2019 12:49:43 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42152 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbfEQQtn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 17 May 2019 12:49:43 -0400
Received: by mail-qk1-f195.google.com with SMTP id d4so4830023qkc.9
        for <cgroups@vger.kernel.org>; Fri, 17 May 2019 09:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YQKQHG4M8LPCgiVUmfj9FmemKS5kDVlDsFXEktM5iKg=;
        b=JlwEd6jJES5oT2oMM1N+aF88PCaJGZbVL2S00a/tVN7D1CWW1/zfUpn5cUuKGDaB9l
         UlF5XO7cIWukxFo6fDDiSa2oRQ55QLnfTtuyxfOk3YwoF/ymTPX0X5XIpWZp66wBEnXy
         HscvZjELUt+WRq5s3oYgfd+z33+tZ8m2fZePp06/ghenLSuYLNnf0U7K5yfSdgXTCVGK
         skLrlpDL+k2boNLwUmm/P2BrEo01J6egfCZKCOUQPpfaMu/knWnEmvHb7p0s2F1PJlr2
         DLqt5ye6VVOFlAR4N/Ut20/jku03Mhcmr4t1S7bYgCu0W/Ew0TJs+hLilSx/17a+35lb
         jing==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=YQKQHG4M8LPCgiVUmfj9FmemKS5kDVlDsFXEktM5iKg=;
        b=hFalktBP0FXFqEwP6Dv/77WYXvmo6nSQESVG0ED8t0TWoq22lTqybFum7VtY4A75h/
         lZyDg/4Me/O6GlEFFn440EqEBSVxQsEXAqXhu5StopjDX8xfFXdp+hSURzDYxblZLAgF
         SbZ1uG7aNjMQMhyzfiSeQdQo/YwX0O757A0IhVE4TVjDwuQjButZ0gAknbTgV9Pl7vwl
         0+L+9gjXFCoAM6beVXtidoD5RjP9RHerAvr7rl9QLaeehsIzI85M6L10p58DHBszPYLY
         U7mHQDhDzgt5a8/HaxiTlg81RvgDhYeFoHuVQoBlRbx+cqU6ELbv8qnvXC08vNTl9E68
         HCRw==
X-Gm-Message-State: APjAAAVwNDPCLeYIFkqHEGbrbaKsCD21a1vFmmRh0MOn+LnEA+NmnTzB
        R6joSXVNjEm6jkDlbgsbIHYNjBqNJYA=
X-Google-Smtp-Source: APXvYqzFyZGeD4zkiSZi3SkSlviqiDubb0dWZREOoe+X7AzBuTjEK1zRAB4f8AsM/c6uNGcqN5Q4RQ==
X-Received: by 2002:a37:4757:: with SMTP id u84mr46276252qka.16.1558111782553;
        Fri, 17 May 2019 09:49:42 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::f042])
        by smtp.gmail.com with ESMTPSA id x18sm3812128qkh.87.2019.05.17.09.49.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 09:49:40 -0700 (PDT)
Date:   Fri, 17 May 2019 09:49:37 -0700
From:   Tejun Heo <tj@kernel.org>
To:     "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
Cc:     "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2 0/4] AMDKFD (AMD GPU compute) support for device
 cgroup.
Message-ID: <20190517164937.GF374014@devbig004.ftw2.facebook.com>
References: <20190517161435.14121-1-Harish.Kasiviswanathan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190517161435.14121-1-Harish.Kasiviswanathan@amd.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, May 17, 2019 at 04:14:52PM +0000, Kasiviswanathan, Harish wrote:
> amdkfd (part of amdgpu) driver supports the AMD GPU compute stack.
> amdkfd exposes only a single device /dev/kfd even if multiple AMD GPU
> (compute) devices exist in a system. However, amdgpu drvier exposes a
> separate render device file /dev/dri/renderDN for each device. To participate
> in device cgroup amdkfd driver will rely on these redner device files.
> 
> v2: Exporting devcgroup_check_permission() instead of
> __devcgroup_check_permission() as per review comments.

Looks fine to me but given how non-obvious it is, some documentation
would be great.

Thanks.

-- 
tejun

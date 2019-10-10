Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0696D1FE1
	for <lists+cgroups@lfdr.de>; Thu, 10 Oct 2019 07:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732671AbfJJFDj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 10 Oct 2019 01:03:39 -0400
Received: from mx5.ucr.edu ([138.23.62.67]:9048 "EHLO mx5.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbfJJFDj (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 10 Oct 2019 01:03:39 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Thu, 10 Oct 2019 01:03:38 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1570683818; x=1602219818;
  h=mime-version:from:date:message-id:subject:to;
  bh=l8fka7UYOSDuLxUdqgi3tx7DvHNj0L8HgAjIPCh+cSg=;
  b=fzTFIZ83Xc8Z52rcnxH13NWSr4xBItyjkISOYC6GYkLgx5r66EhJNxAU
   Gz1MrriMmOuBSQuX+aApkf6syw5UHrKu33xLrZ2NPYPhVU7w0aORAEqlo
   HRRyahpnQm9cNUD7U0KFf/WP+vjB4z8tdWl9F3kv2A9+emZAw4I7oEHVF
   ZTJueATRHMvFu8RRpQWz5bGpvTyWckrXXZSWn8wW+ecckNfA75Gi26vRv
   3ObctPSXn+vcuwJMQEDrkP98rSth3j57PSm3ym8XfHE3P6rlS79uDAC/a
   8CcBfJaogIyth5oCPl6KWwOL//xyXOezF66ViFSQpICp9cGeXnTc88uuW
   Q==;
IronPort-SDR: EmOHKd11NAnsMmwa3NQpDbbgpqBEKDEyUELR/D5f5NXYG/QESvhYl9ls4OiPebNOfasFtSg9ia
 X8NwcbcQIvWrxjL7GaDUO/cGHTP3GgVc9Obe5ygtT51jE+Ubn0YWhpYfHzZtpd+rGMTI61tDe7
 Il5yLuYIGCi85A1nYox4Ngotj6jUeAzBidKTz4wBGQr23uei4jx9gA1AtXCrvydAuegRs1EVCl
 ek53UtNSGitYrFR/Yl2a1QAbOAkKvT4IBJedYSiDfmg16n5C3qXLHhDpuXOoQjaNENPJM3Cwen
 2I0=
IronPort-PHdr: =?us-ascii?q?9a23=3AGlDenh8bYnd67P9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B22+ocTK2v8tzYMVDF4r011RmVBN6dtagP2rKempujcFRI2YyGvnEGfc4EfD?=
 =?us-ascii?q?4+ouJSoTYdBtWYA1bwNv/gYn9yNs1DUFh44yPzahANS47xaFLIv3K98yMZFA?=
 =?us-ascii?q?nhOgppPOT1HZPZg9iq2+yo9JDffgtFiCC8bL9sIxm7qRndvdQKjIV/Lao81g?=
 =?us-ascii?q?HHqWZSdeRMwmNoK1OTnxLi6cq14ZVu7Sdete8/+sBZSan1cLg2QrJeDDQ9Lm?=
 =?us-ascii?q?A6/9brugXZTQuO/XQTTGMbmQdVDgff7RH6WpDxsjbmtud4xSKXM9H6QawyVD?=
 =?us-ascii?q?+/9KpgVgPmhzkbOD446GHXi9J/jKRHoBK6uhdzx5fYbJyJOPZie6/Qe84RS2?=
 =?us-ascii?q?hcUcZLTyFODYOyYYUMAeQcI+hXs5Lwp0cSoRakGQWgGP/jxz1Oi3Tr3aM6ye?=
 =?us-ascii?q?MhEQTe0QMiHtIPsXTUrMjyNKwPUu+1zLPHzTTeZP5R2Tb86YjIfQogof2QQb?=
 =?us-ascii?q?59f9HcyVQzGAPflFmft5HqPy6M2+kLrmOV7PJgWPqxh2I7rwx9uDuiy8c2ho?=
 =?us-ascii?q?XUh48YyErI+CdlzIszONa2UlR0YcS+H5tVryyaMox2Td48TGxwoyY6z6EGuY?=
 =?us-ascii?q?a8fCgX1JQr3x7fZOKDc4iP+h/jUfyeITZ8hH58fLK/iQu+/VGuyuD+SsW4yl?=
 =?us-ascii?q?lKri1CktnDsnACyQbf5dSASvt45kuh2DCP2B7P6uxcP0w4ia7WJ4Qiz7MwjJ?=
 =?us-ascii?q?YfrEXOEy3slEj0kKOabkAk9fKp6+TjbLXmvJicN4pshwD+M6UumtawAeUkPg?=
 =?us-ascii?q?QSUWWW4vm826H5/UHjXrpFk+A2nrHDsJ/GPcQburK5AwhN34k/5Ba/FTCm0M?=
 =?us-ascii?q?kAnXkcN19FZh2HgJbzO13UI/D3E+2/g1Kynzdv3fzGOafhApqeZkTExZXmfb?=
 =?us-ascii?q?977UNHgDU+zNZS/doACrgHJv/ockT0rMzTDhB/NBa7laKvLdR21ooaEUKICa?=
 =?us-ascii?q?yeePfXsViD5eUHIOSWYoIR/jHnJK5hr8DqhHM4nF4HNYWgw4obb27wSupqKl?=
 =?us-ascii?q?uIbX3yxNsMD08FuwM/SKrhj1jUFXZYaGy1Qronzi80BZjgDorZQI2pxrub02?=
 =?us-ascii?q?PzGpxQe3ADD1WkEmnhfIbCXO0DLGqWI8l8gnkHWKKnRosJyx6jrkn5xqBhI+?=
 =?us-ascii?q?6S/TcX8drR1Nlk+uubrBA783QgHcScwnyLVkl/hSUVTCVw0axi9wg14VeO16?=
 =?us-ascii?q?dpnrRjEtpcr6dCSQA8OrbX1KpnAMq0Vw7cKISnUlGjF+SnEzEsSZoDw9YPKx?=
 =?us-ascii?q?JsCdWrj0ibhAK3CKVTmrCWUs9nupnA1mT8cp4ug03N07Ms2hx/GpNC?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2FXAwDPuJ5dgEanVdFlDoZEhE2OW4U?=
 =?us-ascii?q?XAY1pijQBCAEBAQ4vAQGHFyM4EwIDCQEBBQEBAQEBBQQBAQIQAQEJDQkIJ4V?=
 =?us-ascii?q?CgjopAYNVEXwDDAImAiQSAQUBIgEaGoV4BaQ5gQM8iyaBMohkAQkNgUgSeii?=
 =?us-ascii?q?MDoIXgRGLIoJeBIE5AQEBlS+WVwEGAoIQFIxUiEUbgioBlxWOLZlPDyOBRoF?=
 =?us-ascii?q?7MxolfwZngU9PEBSPWlskkUsBAQ?=
X-IPAS-Result: =?us-ascii?q?A2FXAwDPuJ5dgEanVdFlDoZEhE2OW4UXAY1pijQBCAEBA?=
 =?us-ascii?q?Q4vAQGHFyM4EwIDCQEBBQEBAQEBBQQBAQIQAQEJDQkIJ4VCgjopAYNVEXwDD?=
 =?us-ascii?q?AImAiQSAQUBIgEaGoV4BaQ5gQM8iyaBMohkAQkNgUgSeiiMDoIXgRGLIoJeB?=
 =?us-ascii?q?IE5AQEBlS+WVwEGAoIQFIxUiEUbgioBlxWOLZlPDyOBRoF7MxolfwZngU9PE?=
 =?us-ascii?q?BSPWlskkUsBAQ?=
X-IronPort-AV: E=Sophos;i="5.67,278,1566889200"; 
   d="scan'208";a="81859535"
Received: from mail-lf1-f70.google.com ([209.85.167.70])
  by smtpmx5.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Oct 2019 21:56:31 -0700
Received: by mail-lf1-f70.google.com with SMTP id z7so1045327lfj.19
        for <cgroups@vger.kernel.org>; Wed, 09 Oct 2019 21:56:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=qNxdxggCQd3xr6rdB50E8SDcymvAFEfwkLrZ0yN0AVk=;
        b=QrKym3G4MMQUhA/1ROBQWgtfWFRnN9IcYCiA2h1yUeDytaaeUO7WQmez8MCR3GNPbL
         IVyPna2rIp20X/zF/baYI1nKrxUkBpID0P7Q04zoBB5XojZczDvzGLPr6ircNVGAkDWi
         Yx3uwJJBBZfQO0mj54CKKEG2oWpwkj5t0ulRLChP1wrt1tMVad+5VNT97Qzz7hvGTNWR
         K2nD8fVMkZFDgyqFZMqt6wth43JnfQo8NgIwHR2Qh/mhqHn8bvlgMIaP+6ALAhluqrZx
         fslB2rkk9UiS9zP1o1LcaaUuEgtestK84X4MKSYcAYV632vqFfrxmp9a09JwTKqpgYN+
         cp/w==
X-Gm-Message-State: APjAAAXBNRuriZ0aClxtDzR4qZ1nEMBMvuDGk9kIIh3rHN2kx8Wb6h3F
        UVZh3HCkLpOFVD22lYq9LEL4tg+vw3Jo1twmQuDvLu/IsU3PzDoOuPSkuE0QMI1N7B+F9AELMRx
        Xss8sA7EZwLhSJHPmHQ23o304XwA1ZXOWGcE=
X-Received: by 2002:a2e:8315:: with SMTP id a21mr4754244ljh.133.1570683389974;
        Wed, 09 Oct 2019 21:56:29 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy074NwSC68d15vpYDMj4CmQOd5kqAOtBUwTFkuYJ5w5L2OC3C3LTQnOPqg+KMLwvdE5weYDp2K5PS//xB4CKM=
X-Received: by 2002:a2e:8315:: with SMTP id a21mr4754231ljh.133.1570683389789;
 Wed, 09 Oct 2019 21:56:29 -0700 (PDT)
MIME-Version: 1.0
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Date:   Wed, 9 Oct 2019 21:56:04 -0700
Message-ID: <CABvMjLRgShsBiod+GVcqirmKeFLN_KfxdDDwGo22YK0wULepwA@mail.gmail.com>
Subject: Potential NULL pointer deference in mm/memcontrol.c
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Zhiyun Qian <zhiyunq@cs.ucr.edu>,
        Chengyu Song <csong@cs.ucr.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi All:
mm/memcontrol.c:
The function mem_cgroup_from_css() could return NULL, but some callers
in this file
checks the return value but directly dereference it, which seems
potentially unsafe.
Such callers include mem_cgroup_hierarchy_read(),
mem_cgroup_hierarchy_write(), mem_cgroup_read_u64(),
mem_cgroup_reset(), etc.
-- 
Kind Regards,

Yizhuo Zhai

Computer Science, Graduate Student
University of California, Riverside
